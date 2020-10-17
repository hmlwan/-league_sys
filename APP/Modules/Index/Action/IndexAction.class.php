<?php

Class IndexAction extends CommonAction
{
  /**
   * 生成验证码
   */
  public function verify()
  {
    ob_clean();
    import('ORG.Util.Image');
    Image::buildImageVerify(4, 1, 'png', 55, 25);
  }

  //首页
  public function index()
  {
      $member = D('Member');
      $user_id = session('mid');
      $info = $member->getByUserId($user_id);
      $jifen_arr = explode('.',$info['jifen']);
      $lmjifen_arr = explode('.',$info['lmjifen']);
      $this->assign('jifen_arr',$jifen_arr);
      $this->assign('lmjifen_arr',$lmjifen_arr);

      //分红
      $mineral_num = 0;
      if($info['jifen'] > 0){
          $bonus_m = D('Bonus');
          $last_record_where = array(
              'user_id' => $user_id
          );
          $last_record = $bonus_m->getLastRecord($last_record_where);

          /*间隔时间*/
          $bonus_wait_minute_product_mineral = getConf('bonus_wait_minute_product_mineral');
          $bonus_wait_minute_product_mineral = $bonus_wait_minute_product_mineral * 60;
          if($last_record){
              $interval_second = time() - $last_record['add_time'];
          }else{
              $interval_second = time() - $info['regdate'];
          }
          //矿石数量
          $mineral_num = floor($interval_second / $bonus_wait_minute_product_mineral);
      }

      $this->assign('mineral_num',$mineral_num);

      $counsel_db = M('counsel');
      /*热门咨询*/
      $zx_list = $counsel_db->where(array('type_id'=>1))->order('sort desc')->limit(4)->select();
      $zx_count = $counsel_db->where(array('type_id'=>1))->count();
      /*热门交易所*/
      $jys_list = $counsel_db->where(array('type_id'=>2))->order('sort desc')->limit(4)->select();
      $jys_count = $counsel_db->where(array('type_id'=>2))->count();
      /*热门项目*/
      $xm_list = $counsel_db->where(array('type_id'=>3))->order('sort desc')->limit(3)->select();
      $xm_count = $counsel_db->where(array('type_id'=>3))->count();

      $is_senior_cert = 0;
      $member_senior_info = M('member_senior_cert')->where(array('user_id'=>$user_id))->find();
      if($member_senior_info && $member_senior_info['is_senior_cert'] == 1){
          $is_senior_cert = 1;
      }

      $data = array(
          'zx_list' => $zx_list,
          'zx_count' => $zx_count,
          'jys_list' => $jys_list,
          'jys_count' => $jys_count,
          'xm_list' => $xm_list,
          'xm_count' => $xm_count,
          'is_senior_cert' => $is_senior_cert,
      );

      $this->assign($data);
      $this->display();
  }

  //领取分红
  public function bonus_op(){
      $member = D('Member');

      $user_id = session('mid');
      $info = $member->getByUserId($user_id);
      //分红
      $bonus_m = D('Bonus');
      $last_record_where = array(
          'user_id' => $user_id
      );
      $last_record = $bonus_m->getLastRecord($last_record_where);

      $bonus_start_receive = getConf('bonus_start_receive');
      $bonus_end_receive = getConf('bonus_end_receive');
      if(time()< strtotime($bonus_start_receive) || time() > strtotime($bonus_end_receive) ){
          $this->ajaxReturn(array('info' => "领取时间为{$bonus_start_receive}-{$bonus_end_receive}"));
      }
      if($info['jifen'] <= 0){
          $this->ajaxReturn(array('info' => "有效积分不足"));
      }

      $bonus_wait_minute_receive = getConf('bonus_wait_minute_receive');
      $bonus_wait_minute = $bonus_wait_minute_receive * 60;
      if($last_record){
          $interval_second = time() - $last_record['add_time'];
          $next_receive_time = $last_record['add_time'] + $bonus_wait_minute;
      }else{
          $interval_second = time() - $info['regdate'];
          $next_receive_time = $info['regdate'] + $bonus_wait_minute;
      }
      if($interval_second < $bonus_wait_minute){
          $next_receive_time = date("H:i",$next_receive_time);
          $this->ajaxReturn(array('info' => "下次领取时间{$next_receive_time}"));
      }

      $during_minute = floor($interval_second / 60);
      $bonus_product_lmjf = getConf('bonus_product_lmjf');
      $receive_lmjf = $bonus_product_lmjf * $during_minute * $info['jifen'];
      $receive_lmjf = set_number($receive_lmjf,4);

      $record_r = $bonus_m->saveProductRecord(array(
          'user_id' => $user_id,
          'num' => $receive_lmjf,
          'accumulate_minute' => $during_minute,
          'add_time' => time(),
          'sf_jifen' => $info['jifen'],
          'next_receive_time' => time() + $bonus_wait_minute,
      ));
      if(!$record_r){
          $this->ajaxReturn(array('info' => "领取失败"));
      }
      //明细
      D('UserLeagueLog')->changeUserNum($user_id,array(
          'num' => $receive_lmjf,
          'remark' => '生态分红'.$receive_lmjf.'联盟积分',
          'type'=> 1,
      ));
      $this->ajaxReturn(array('info' => "获得{$receive_lmjf}联盟积分", 'result' => 1, 'toUrl' => U('/index/index/index')));
  }
  public function get_more(){
      $type_id = I('get.type_id');
      $counsel_db = M('counsel');
      $where['type_id'] = $type_id;
      $count = $counsel_db->where($where)->count();
      $Page  = new Page($count,6);
      $list =  $counsel_db->where(array('type_id'=>$type_id))
          ->limit ( $Page->firstRow . ',' . $Page->listRows )
          ->order('sort desc')
          ->select();
      if($list){
          foreach ($list as &$value){
              $value['content'] = stripslashes($value['content']);
          }
      }
      $this->assign('list', $list);
      $this->assign('type_id', $type_id);
      if(IS_AJAX){
          $data['content'] = $this->fetch('ajax_get_more');
          $data['count'] = array(
              'totalRows'=> $count,
              'listRows'=> 6,
          );
          $this->ajaxReturn($data);
      }else{
          $this->display();
      }
  }

    /*合约地址*/
  public function contract_address(){
      $this->display();
  }
    /*白皮书*/
  public function white_paper(){
     $this->display();
  }
    /*经济书*/
    public function economic_book(){
        $this->display();
    }
  //个人信息
  public function personal()
  {
    $member = M('member');
    $username = session('username');
    $id = session('mid');
    $minfo = $member->where(array('username' => $username))->find();
    $list = M('bankcard')->where(array('userid' => $id))->find();
    $this->assign('list', $list);
    $this->assign('minfo', $minfo);
    $this->display();
  }

  //资料修改
  public function edit()
  {
    $member = M('member');
    $username = session('username');
    $minfo = $member->where(array('username' => $username))->find();
    $this->assign('minfo', $minfo);
    $this->display();
  }

  //银行卡
  public function card()
  {
    $userid = session('mid');
    $list = M('bankcard')->where(array('userid' => $userid))->find();

    $name = M('member')->where(array('id' => $userid))->getField('truename');

    $this->assign('name', $name);
    $this->assign('list', $list);
    $this->display();
  }

  //添加银行卡执行
  public function addcardpost()
  {
    if (IS_AJAX) {
      $name['truename'] = I('post.truename');
      $data['name'] = I('post.name');
      $data['kaihuhang'] = I('post.kaihuhang');
      $data['card'] = I('post.card');

      if (empty($name['truename'])) {
        $this->ajaxReturn(array('info' => '请输入真实姓名！', 'url' => U('Index/index/card')));
      }
      if (empty($data['name'])) {
        $this->ajaxReturn(array('info' => '请输入银行名称！', 'url' => U('Index/index/card')));
      }
      if (empty($data['kaihuhang'])) {
        $this->ajaxReturn(array('info' => '请输入开户行！', 'url' => U('Index/index/card')));
      }

      if (empty($data['card'])) {
        $this->ajaxReturn(array('info' => '请输入银行卡号！', 'url' => U('Index/index/card')));
      }

      $userid = session('mid');
      $bankcard = M('bankcard')->where(array('userid' => $userid))->find();
      $this->assign('bankcard', $bankcard);

      if ($bankcard == "") {

        $data1['userid'] = session('mid');
        $data1['name'] = $data['name'];
        $data1['kaihuhang'] = $data['kaihuhang'];
        $data1['card'] = $data['card'];
        $result = M('bankcard')->add($data1);
        if (!empty($result)) {

          $this->ajaxReturn(array('result' => 1, 'info' => '银行卡添加成功', 'url' => U('Index/index/personal')));
        } else {
          $this->ajaxReturn(array('result' => 0, 'info' => '银行卡添加失败', 'url' => U('Index/index/addcard')));
        }
      } else {

        $result1 = M('bankcard')->where(array('userid' => $userid))->save($data);
        if (!empty($result1)) {
          M('member')->where(array('id' => $userid))->save($name);
          $this->ajaxReturn(array('result' => 1, 'info' => '银行卡修改成功', 'url' => U('Index/index/personal')));
        } else {
          $this->ajaxReturn(array('result' => 0, 'info' => '银行卡修改失败', 'url' => U('Index/index/addcard')));
        }
      }
    }
}

  //支付宝
  public function zhifu()
  {
    $username = session('username');
    $receive = M('member')->where(array('username' => $username))->getField('zhifu');
    $this->assign('receive', $receive);

    $this->display();
  }

  //支付宝
  public function zhifupost()
  {

    $userid = session('mid');

    $data['zhifu'] = I('post.receive');

    if (empty($data['zhifu'])) {
      alert('收款地址不可为空！', U('Index/index/zhifu'));
    }
    $result = M('member')->where(array('id' => $userid))->save($data);
    if (!empty($result)) {
      alert('修改成功', U('Index/wallet/index'));
    } else {

      alert('修改失败', U('Index/index/zhifu'));
    }
  }

  //微信
  public function wei()
  {

    $this->display();
  }

  //支付宝
  public function weipost()
  {

    $userid = session('mid');
    $data['wei'] = I('post.images');
    if (empty($data['wei'])) {
      alert('请上传微信收款码', U('Index/index/wei'));
    }
    $result = M('member')->where(array('id' => $userid))->save($data);
    if (!empty($result)) {
      alert('微信修改成功', U('Index/index/personal'));
    } else {

      alert('微信修改失败', U('Index/index/wei'));
    }

  }

  //资料修改
  public function editname()
  {
    if (IS_AJAX) {
      $data['truename'] = I('post.truename');
      $data['name'] = I('post.name');
      if (empty($data['truename'])) {
        $this->ajaxReturn(array('result' => 0, 'info' => '真实姓名不能为空!'));
      }
      if (empty($data['name'])) {
        $this->ajaxReturn(array('result' => 0, 'info' => '昵称不能为空!'));
      }

      $db = M('member');
      $where = array('id' => session('mid'));

      if ($db->where($where)->save($data)) {
        $this->ajaxReturn(array('result' => 1, 'info' => '资料修改成功', 'url' => U('Index/index/personal')));
      } else {
        $this->ajaxReturn(array('result' => 0, 'info' => '资料修改失败', 'url' => U('Index/index/personal')));
      }
    }
  }

  //我的团队
  public function team()
  {
    $member = M('member');
    $username = session('username');

    $count = $member->where(array('parent' => $username))->count();
    $list = $member->where(array('parent' => $username))->field('username,id,money,truename')->select();

    foreach ($list as $k => $v) {
      $list[$k]['zhitui'] = $member->where(array('parent' => $v['username']))->count();
    }
    $parentcount1 = $member->where(array('username' => $username))->getField('parentcount');
    $parentcount = $parentcount1 - $count;
    $this->assign('count', $count);
    $this->assign('parentcount', $parentcount);
    $this->assign('list', $list);
    //$this->assign('list1',$list1);
    $this->display();
  }

  //我的团队
  public function zhitui()
  {
    $member = M('member');
    $username = session('username');
    $minfo = $member->where(array('username' => $username))->find();
    $list = $member->where(array('parent' => $username))->field('username,id,money,truename')->select();
    $totalCount = M('order')->where(array('user' => $username, 'zt' => 1))->count() > 0 ? M('order')->where(array('user' => $username, 'zt' => 1))->count() : 0;// 初始化
    $totalPeople = $member->where(array('parent_id' => $minfo['id']))->count();
    $child = $member->where(array('parent_id' => $minfo['id']))->select();
    $zt = $member->where(array('parent_id' => $minfo['id']))->count() > 0 ? $member->where(array('parent_id' => $minfo['id']))->count() : 0;
    if ($child) {
      foreach ($child as $key => $v) {
        $tmp = M('order')->where(array('user' => $v['username'], 'zt' => 1))->count();
        $totalCount += $tmp;
        $nextChild = $member->where(array('parent_id' => $v['id']))->find();
        if ($nextChild) {
          foreach ($nextChild as $key2 => $v2) {
            $tmp = M('order')->where(array('user' => $v2['username'], 'zt' => 1))->count();
            $totalCount += $tmp;
            $finalChild = $member->where(array('parent_id' => $v2['id']))->find();
            if ($finalChild) {
              foreach ($finalChild as $key3 => $v3) {
                $tmp = M('order')->where(array('user' => $v3['username'], 'zt' => 1))->count();
                $totalCount += $tmp;
              }
            }
          }
        }
      }
      foreach ($child as $keys => $vs) {
        $tmp = M('member')->where(array('parent_id' => $vs['id']))->count();
        $totalPeople += $tmp;
        $nextChild = $member->where(array('parent_id' => $vs['id']))->count();
        $totalPeople += $nextChild;
      }
    }

    foreach ($list as $key => $v) {
      $list[$key]['zhitui'] = $member->where(array('parent' => $v['username']))->count();
    }
    $this->assign('totalPeople', $totalPeople);
    $this->assign('zhitui', $zt);
    $this->assign('list',$list);
    $this->assign('totalCount', $totalCount);
    $this->display();
  }

  //推广码
  public function tgm()
  {

    header("Content-type: text/html; charset=utf-8");

    // $e_keyid = encrypt(session('mid'), 'E', 'xyb8888');
    $inviteCode = M('member')->where(array('id' => session('mid')))->getField('inviteCode');
    $e_keyid = encrypt($inviteCode, 'E', 'xyb8888');

    $e_keyid = str_replace('/', 'AAABBB', $e_keyid);

    $tuiguangma = "http://" . $_SERVER['SERVER_NAME'] . U('Index/Sem/regSem', array('u' => $inviteCode));
    $erwei = M("member")->where(array('username' => session('username')))->getField("erwei");
    // echo $tuiguangma;
    if ($erwei) {
      //Vendor('phpqrcode.phpqrcode');
      ////生成二维码图片
      //$object = new QRcode;
      //$level = 3;
      //$size = 0;
      //$errorCorrectionLevel = intval($level);//容错级别
      //$matrixPointSize = intval($size);//生成图片大小
      $path = "Public/erwei/";
      //// 生成的文件名
      $fileName = $path . session('username') . '.png';
      //$object->png($tuiguangma, $fileName, $errorCorrectionLevel, $matrixPointSize, 2);

      import('ORG.Util.Image');
      $Image = new Image();

      define('THINKIMAGE_WATER_CENTER', 5);
      $Image->water(PUBLIC_PATH . '/encard.jpg');
      $erwei = '/' . $fileName;

      M("member")->where(array('username' => session('username')))->setField("erwei", $erwei);
    }
    $this->assign('erwei', $erwei);
    $adurl = C('adurl');
    $adurl2 = str_replace('[adurl]', $tuiguangma, $adurl);

    $this->assign('tuiguangma', $tuiguangma);
    $this->assign('adurl2', $adurl2);
    $this->assign('inviteCode', $inviteCode);
    $this->display();
  }

  //分享
  public function fenxiang()
  {
    header("Content-type: text/html; charset=utf-8");

    $e_keyid = encrypt(session('mid'), 'E', 'xyb8888');

    $e_keyid = str_replace('/', 'AAABBB', $e_keyid);

    $tuiguangma = "http://" . $_SERVER['SERVER_NAME'] . U('Index/Sem/regSem', array('u' => $e_keyid));
    $erwei = M("member")->where(array('username' => session('username')))->getField("erwei");

    if (!$erwei) {
      Vendor('phpqrcode.phpqrcode');
      //生成二维码图片
      $object = new QRcode;
      $level = 3;
      $size = 5;
      $errorCorrectionLevel = intval($level);//容错级别
      $matrixPointSize = intval($size);//生成图片大小
      $path = "Public/erwei/";
      // 生成的文件名
      $fileName = $path . session('username') . '.png';
      $object->png($tuiguangma, $fileName, $errorCorrectionLevel, $matrixPointSize, 2);

      import('ORG.Util.Image');
      $Image = new Image();

      define('THINKIMAGE_WATER_CENTER', 5);
      $Image->water(PUBLIC_PATH . '/encard.jpg', $fileName, $fileName, 100, array(425, 1125));
      $erwei = '/' . $fileName;

      M("member")->where(array('username' => session('username')))->setField("erwei", $erwei);
    }
    $this->assign('erwei', $erwei);
    $this->display();
  }
  public function _empty(){
      $this->display('404');
  }
  //客服
  public function kefu()
  {

    $kefu1 = C('kefu1');
    $kefu2 = C('kefu2');
    $kefu3 = C('kefu3');
    $this->assign('kefu1', $kefu1);
    $this->assign('kefu2', $kefu2);
    $this->assign('kefu3', $kefu3);
    $this->display();
  }

  //密码修改
  public function updatePass()
  {

    $this->display();
  }

  //执行密码修改
  public function updatePasspost()
  {


    $old_password = I('post.old_password', '', 'strval');
    if (empty($old_password)) {
      $this->ajaxReturn(array('result' => 0, 'info' => '原密码不能为空!'));
    }
    $db = M('member');
    $newpwd = I('post.newpwd', '', 'strval');
    $newpwd1 = I('post.newpwd1', '', 'strval');
    if (empty($newpwd) || empty($newpwd1)) {
      $this->ajaxReturn(array('result' => 0, 'info' => '新登陆密码或确认密码不能为空'));
    }
    if (!preg_match("/^[a-zA-Z\d_]{6,}$/", I('post.newpwd'))) {
      $this->ajaxReturn(array('result' => 0, 'info' => '新密码长度不能小于6位!'));
    }
    if ($newpwd != $newpwd1) {
      $this->ajaxReturn(array('result' => 0, 'info' => '两次密码输入不一样!'));
    }
    $where = array('id' => session('mid'));
    $old = $db->where($where)->getField('password');
    if ($old != MD5($old_password)) {
      $this->ajaxReturn(array('result' => 0, 'info' => '原登陆密码错误'));
    }
    if ($db->where($where)->save(array('password' => MD5($newpwd)))) {
      $this->ajaxReturn(array('result' => 1, 'info' => '登陆密码修改成功', 'url' => U('Index/index/index')));
    } else {
      $this->ajaxReturn(array('result' => 0, 'info' => '登陆密码修改失败', 'url' => U('Index/index/index')));
    }

  }

  //退出系统
  public function logout()
  {
    //添加日志
    $desc = '会员' . session('account') . '退出';
    write_log(session('account'), 'member', $desc);
    session('mid', null);
    session('username', null);
    session('member', null);
    session('usersecondlogin', null);
    $this->redirect(GROUP_NAME . '/Login/index');
  }


}

?>