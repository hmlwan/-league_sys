<?php

//消息相关控制器
Class WalletAction extends CommonAction
{


  public function index()
  {
    $member = M('member');
    $username = session('username');
    $minfo = $member->where(array('username' => $username))->find();

    $count = M('order')->where(array('user' => $username, 'zt' => 1))->count();
    $chengzhu = C('chengzhu');
    $totalCount = 0;// 初始化
    $child = $member->where(array('parent_id' => $minfo['id']))->select();
    if ($child) {
      foreach ($child as $key => $v) {
        $tmp = M('order')->where(array('user' => $v['username'], 'zt' => 1))->count();
        $totalCount += $tmp;
        $nextChild = $member->where(array('parent_id' => $v['id']))->find();
        if ($nextChild) {
          foreach ($nextChild as $key2 => $v1) {
            $tmp = M('order')->where(array('user' => $v1['username'], 'zt' => 1))->count();
            $totalCount += $tmp;
            $finalChild = $member->where(array('parent_id' => $v1['id']))->find();
            if ($finalChild) {
              foreach ($finalChild as $key3 => $v3) {
                $tmp = M('order')->where(array('user' => $finalChild['username'], 'zt' => 1))->count();
                $totalCount += $tmp;
              }
            }
          }
        }
      }
    }
    if ($totalCount >= $chengzhu) {
      $data['level'] = 1;
      M('member')->where(array('username' => $username))->save($data);
    }
    $level = M('member')->where(array('username' => $username))->getField('level');
    $imgurl = '/public//shu/12.png';
    if ($level == 1) {
      $imgurl = '/public//shu/13.png';
    } else {
      $imgurl = '/public//shu/12.png';
    }
    $avatar = '/Public/' . $minfo['avatar'];
    if (empty($minfo['avatar'])) {
      $avatar = '/public/dianyun/img/logo.png';
    }
    // 总资产
    $startTotal = M('order')->where(array('user' => $username, 'zt' => 1))->select();
    // $shouyi = M('order')->where(array('user' => $username))->sum('already_profit');
    $finalTotal = 0;
    if ($startTotal) {
      foreach ($startTotal as $v) {
        $tmp = $v['yxzq'] * $v['shouyi'] - $v['	already_profit'];
        $finalTotal += $tmp;
      }
    }
    // 今日收益
    $map['member'] = session('username');
    $map['type'] = array("eq", 1);
    $map['queryTime'] = array("eq", date("Y-m-d", time()));
    $sum = M('jinbidetail')->where($map)->sum('adds');
    $map['type'] = array("eq", 2);
    $sum2 = M('jinbidetail')->where($map)->sum('adds');
    $profitTotal = $sum + $sum2;
    $this->assign('count', $count);
    $this->assign('minfo', $minfo);
    $this->assign('avatar', $avatar);
    $this->assign('imgurl', $imgurl);
    $this->assign('finalTotal', $finalTotal);
    $this->assign('profitTotal', $profitTotal);
    $this->display();
  }


  //提现
  public function tixian()
  {
  	    //是否开启提现功能
    if (C('WITHDRAW_STATUS') == 'off') {
      alert('提现暂未开放', U('Index/wallet/change'));
    }
    $tx_time = C('tx_time');
    $shouxu = C('WITHDRAW_TAX');
    if (!empty($tx_time)) {
      $tx_time_arr = explode('-', $tx_time);
      $s_time = strtotime(date("Y-m-d " . $tx_time_arr[0]));
      $o_time = strtotime(date("Y-m-d " . $tx_time_arr[1]));
      if (time() < $s_time || time() > $o_time) {
        alert('提现时间为' . $tx_time, U('Index/wallet/index'));
        exit;
      }
    }
    $username = session('username');
    $money = M('member')->where(array('username' => $username))->getField('money');
    $receive = M('member')->where(array('username' => $username))->getField('zhifu');
    $yiti = M('emoneydetail')->where(array('username' => $username, 'status' => 1))->sum('amount');
    $money = sprintf('%.2f', $money);
    $yiti = sprintf('%.2f', $yiti);

    $this->assign('money', $money);
    $this->assign('yiti', $yiti);
    $this->assign('receive', $receive);
    $this->display();
  }

  //提现
  public function withdrawn()
  {

    //是否开启提现功能
    if (C('WITHDRAW_STATUS') == 'off') {
      alert('提现暂未开放', U('Index/wallet/change'));
    }
    $tx_time = C('tx_time');
    $shouxu = C('WITHDRAW_TAX');
    if (!empty($tx_time)) {
      $tx_time_arr = explode('-', $tx_time);
      $s_time = strtotime(date("Y-m-d " . $tx_time_arr[0]));
      $o_time = strtotime(date("Y-m-d " . $tx_time_arr[1]));
      if (time() < $s_time || time() > $o_time) {
        alert('提现时间为' . $tx_time, U('Index/wallet/index'));
        exit;
      }
    }
    $this->assign('shouxu', $shouxu);
    $this->display();
  }

  public function payreq()
  {
    $out_trade_no = $this->create_ordersn();
    $name = '充值';
    $money = $_POST['money'];
    $type = $_POST['type'];
    $sitename = 'XXXX游戏';
    $url = "http://" . $_SERVER['HTTP_HOST'] . '/sdk/epayapi.php?WIDout_trade_no=' . $out_trade_no . '&type=' . $type . '&WIDtotal_fee=' . $money;
    $username = session('username');
    $data['pay_no'] = $out_trade_no;
    $data['pay_id'] = $username;
    if ($_POST['type'] == 'wxpay') {
      $type = 3;
    } else {
      $type = 1;
    }
    $data['type'] = $type;
    $data['price'] = $_POST['money'];
    $data['pay_time'] = time();
    $data['status'] = 0;
    $query = M('pay')->add($data);
    if ($query) {
      $this->ajaxReturn(array('result' => 1, 'url' => $url));
    } else {
      $this->ajaxReturn(array('result' => 0, 'info' => '创建订单失败！'));
    }

  }

  public function create_ordersn()
  {
    $order_no = date('Ymd') . substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%02d', rand(1000, 9999));
    return $order_no;
  }

  //提现执行
  public function withpost()
  {

    if (IS_AJAX) {

      $txmoney = I('post.money');
      $username = session('username');
      $member = M('member')->where(array('id' => session('mid')))->find();
      $balance = M('member')->where(array('id' => session('mid')))->getField('money');
      $txcount = M('emoneydetail')->where(array('username' => session('username'), 'status' => 0))->count();
      $isBind = $member['zhifu'];

      if (empty($isBind)) {
        $this->ajaxReturn(array('info' => '未绑定付款码！'));
      }

      if ($txcount > 0) {
        $this->ajaxReturn(array('info' => '您当前有未处理完成的提现订单！'));
      }
      $s_time = strtotime(date("Y-m-d 00:00:01"));
      $o_time = strtotime(date("Y-m-d 23:59:59"));
      $cishu = C('WITHDRAW_IN_DAY_NUM');
      $ztxcount = M('emoneydetail')->where("addtime > {$s_time} and addtime < {$o_time} and username = {$username}")->count();
      if ($ztxcount >= $cishu) {
        $this->ajaxReturn(array('info' => '每天最多可提现次数为' . $cishu . '次！'));
      }

      if ($txmoney == 0) {
        $this->ajaxReturn(array('info' => '请正确填写提现金额！'));
      }
      if ($txmoney > $balance) {
        $this->ajaxReturn(array('info' => '对不起，您的可提现金额不足！'));
      }

      //是否开启提现功能
      if (C('WITHDRAW_STATUS') == 'off') {

        $this->ajaxReturn(array('info' => '提现暂未开放！', 'result' => '1', 'url' => U('Index/Wallet/index')));
      }
      $tx_time = C('tx_time');
      if (!empty($tx_time)) {
        $tx_time_arr = explode('-', $tx_time);
        $s_time = strtotime(date("Y-m-d " . $tx_time_arr[0]));
        $o_time = strtotime(date("Y-m-d " . $tx_time_arr[1]));
        if (time() < $s_time || time() > $o_time) {

          $this->ajaxReturn(array('info' => '提现时间为\'.$tx_time', 'result' => '1'));
          exit;
        }
      }
      //一次性提现最少额度
      if ($txmoney < C('WITHDRAW_MIN')) {

        $this->ajaxReturn(array('info' => '您输入的提现金额小于最少提现金额，请输入至少' . C('WITHDRAW_MIN') . '提现额！'));
      }
      //设置提现整数倍
      if (C('WITHDRAW_INT') > 0) {
        if ($txmoney % C('WITHDRAW_INT') != 0) {

          $this->ajaxReturn(array('info' => '您输入的提现金额必须为' . C('WITHDRAW_INT') . '的整数倍！'));
        }
      }
      //提现手续费点位、手续费上限、手续费下限	设置提现的时候要扣除的手续费即x%
      if (C('WITHDRAW_TAX') > 0) {
        $withdrawtaxnum = $txmoney * (C('WITHDRAW_TAX') / 100);
      }
      $withdrawtaxnum = intval($withdrawtaxnum);
      $txmoney = intval($txmoney);
      //正式处理
      $banks = M('bankcard')->where(array('userid' => session('mid')))->find();
      $data['account'] = $username;
      $data['amount'] = $txmoney;
      $data['location'] = $member['zhifu'];
      $data['applyDate'] = time();

      if (M('member_receive')->data($data)->add()) {
        M('member')->where(array('username' => session('username')))->setDec('money', $txmoney);
        account_log($data['username'], $txmoney, ' 提现', 0);
        M('member')->where(array('username' => session('username')))->setInc('dongjie', $txmoney);
        account_log4($data['username'], $txmoney, ' 提现冻结', 1);

        $this->ajaxReturn(array('info' => '提现成功！', 'result' => '1', 'url' => U('Index/Wallet/withdrawnlog')));
      } else {
        $this->ajaxReturn(array('info' => '提现失败！', 'result' => '1', 'url' => U('Index/Wallet/withdrawn')));
      }
    }
  }


  //提现记录
  public function withdrawnlog()
  {
    $emoneydetail = M('emoneydetail');
    $username = session('username');

    $list = $emoneydetail->where(array('username' => $username))->order('addtime desc')->select();


    $this->assign('list', $list);
    $this->display();
  }

  //全部奖励
  public function award()
  {

    $data = M('jinbidetail');
    import('ORG.Util.Page');
    $map['member'] = session('username');
    $map['type'] = array("eq", 1);
    $count = $data->where($map)->count();
    $page = new Page($count, 8);
    $page->setConfig('theme', '%first% %upPage% %linkPage% %downPage% %end%');
    $show = $page->show();// 分页显示输出
    $list = $data->where($map)->order('id desc')->limit($page->firstRow . ',' . $page->listRows)->select();

    $shouyi = M('order')->where(array('user' => $map['member']))->sum('already_profit');
    $yue = M('member')->where(array('username' => session('username')))->getField('money');
    $yiti = M('emoneydetail')->where(array('username' => $map['member'], 'status' => 1))->sum('amount');
    $shouyi = sprintf('%.2f', $shouyi);
    $yue = sprintf('%.2f', $yue);
    $yiti = sprintf('%.2f', $yiti);

    $this->assign('shouyi', $shouyi);
    $this->assign('yue', $yue);
    $this->assign('yiti', $yiti);
    $this->assign('list', $list);
    $this->assign('page', $show);
    $this->display();
  }

  //生态收益
  public function ecologyaward()
  {

    $data = M('jinbidetail');
    import('ORG.Util.Page');
    $map['member'] = session('username');
    $map['type'] = array("eq", 2);
    $count = $data->where($map)->count();
    $page = new Page($count, 8);
    $page->setConfig('theme', '%first% %upPage% %linkPage% %downPage% %end%');
    $show = $page->show();// 分页显示输出
    $list = $data->where($map)->order('id desc')->limit($page->firstRow . ',' . $page->listRows)->select();

    $shouyi = $data->where($map)->sum('adds');
    $yue = M('member')->where(array('username' => session('username')))->getField('money');
    $yiti = M('emoneydetail')->where(array('username' => $map['member'], 'status' => 1))->sum('amount');
    $shouyi = sprintf('%.2f', $shouyi);
    $yue = sprintf('%.2f', $yue);
    $yiti = sprintf('%.2f', $yiti);

    $this->assign('shouyi', $shouyi);
    $this->assign('yue', $yue);
    $this->assign('yiti', $yiti);
    $this->assign('list', $list);
    $this->assign('page', $show);
    $this->display();
  }

  public function uploads()
  {
    if (isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST") {
      $name = $_FILES['photoimg']['name'];
      $size = $_FILES['photoimg']['size'];

      $file_time = date('Ymd', time());
      $file_name = './Public/Uploads/touxiang/';
      if (!file_exists($file_name)) {
        mkdir($file_name);
      }
      $path = $file_name . '/';

      $extArr = array("jpg", "png", "jpeg", "gif");
      if (empty($name)) {
        echo json_encode(array('result' => 0, 'msg' => '请选择要上传的图片'));
        return;

      }
      $ext = $this->extend($name);
      if (!in_array($ext, $extArr)) {
        echo json_encode(array('result' => 0, 'msg' => '图片格式错误'));
        return;

      }
      if ($size > (300 * 1024 * 1024)) {
        echo json_encode(array('result' => 0, 'msg' => '图片大小不能超过3M'));
        return;

      }
      $image_name = time() . rand(100, 999) . "." . $ext;
      $tmp = $_FILES['photoimg']['tmp_name'];

      $uploadip = substr($path, 9);
      if (move_uploaded_file($tmp, $path . $image_name)) {
        $url = $uploadip . $image_name;
        M('member')->where(array('username' => session('username')))->save(array('avatar' => $url));
        echo json_encode(array('result' => 1, 'url' => $url));
        return;
      } else {
        echo json_encode(array('result' => 0, 'msg' => '上传出错了'));
        return;
      }
      exit;
    }
    exit;

  }

  public function uploadsRecharge()
  {
    if (isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST") {
      $name = $_FILES['photoimg']['name'];
      $size = $_FILES['photoimg']['size'];

      $file_time = date('Ymd', time());
      $file_name = './Public/Uploads/recharge/';
      if (!file_exists($file_name)) {
        mkdir($file_name);
      }
      $path = $file_name . '/';

      $extArr = array("jpg", "png", "jpeg", "gif");
      if (empty($name)) {
        echo json_encode(array('result' => 0, 'msg' => '请选择要上传的图片'));
        return;

      }
      $ext = $this->extend($name);
      if (!in_array($ext, $extArr)) {
        echo json_encode(array('result' => 0, 'msg' => '图片格式错误'));
        return;

      }
      if ($size > (300 * 1024 * 1024)) {
        echo json_encode(array('result' => 0, 'msg' => '图片大小不能超过3M'));
        return;

      }
      $image_name = time() . rand(100, 999) . "." . $ext;
      $tmp = $_FILES['photoimg']['tmp_name'];

      $uploadip = substr($path, 9);
      if (move_uploaded_file($tmp, $path . $image_name)) {
        $url = $uploadip . $image_name;
        echo json_encode(array('result' => 1, 'url' => $url));
        return;
      } else {
        echo json_encode(array('result' => 0, 'msg' => '上传出错了'));
        return;
      }
      exit;
    }
    exit;

  }

  public function extend($file_name)
  {
    $extend = pathinfo($file_name);
    $extend = strtolower($extend["extension"]);
    return $extend;
  }

  public function payConfirm()
  {
    $data['amount'] = $_POST['money'];
    $data['imageUrl'] = $_POST['imageUrl'];
    $data['account'] = session('username');
    $data['applyDate'] = time();
    $data['ordersn'] = $this->makeOrderSn();
    $arr['result'] = 1;
    if (M('member_paylist')->add($data)) {
      exit(json_encode($arr));
    } else {
      $arr['result'] = 0;
      $arr['info'] = '创建订单出错！';
      exit(json_encode($arr));
    }
  }

  public function makeOrderSn()
  {
    return date('Ymd') . substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
  }

  //流量奖励
  public function llaward()
  {

    $data = M('jinbidetail');
    import('ORG.Util.Page');
    $map['member'] = session('username');
    $map['type'] = array("eq", 1);
    $count = $data->where($map)->count();
    $page = new Page($count, 8);
    $page->setConfig('theme', '%first% %upPage% %linkPage% %downPage% %end%');
    $show = $page->show();// 分页显示输出
    $list = $data->where($map)->order('id desc')->limit($page->firstRow . ',' . $page->listRows)->select();

    $shouyi = M('order')->where(array('user' => $map['member']))->sum('already_profit');
    $yue = M('member')->where(array('username' => session('username')))->getField('money');
    $yiti = M('emoneydetail')->where(array('username' => $map['member'], 'status' => 1))->sum('amount');
    $shouyi = sprintf('%.2f', $shouyi);
    $yue = sprintf('%.2f', $yue);
    $yiti = sprintf('%.2f', $yiti);

    $this->assign('shouyi', $shouyi);
    $this->assign('yue', $yue);
    $this->assign('yiti', $yiti);
    $this->assign('list', $list);
    $this->assign('page', $show);
    $this->display();
  }

  //推广奖励
  public function tgaward()
  {

    $data = M('jinbidetail');
    import('ORG.Util.Page');
    $map['member'] = session('username');
    $map['type'] = array("eq", 2);
    $count = $data->where($map)->count();
    $page = new Page($count, 8);
    $page->setConfig('theme', '%first% %upPage% %linkPage% %downPage% %end%');
    $show = $page->show();// 分页显示输出
    $list = $data->where($map)->order('id desc')->limit($page->firstRow . ',' . $page->listRows)->select();

    $shouyi = M('order')->where(array('user' => $map['member']))->sum('already_profit');
    $yue = M('member')->where(array('username' => session('username')))->getField('money');
    $yiti = M('emoneydetail')->where(array('username' => $map['member'], 'status' => 1))->sum('amount');
    $shouyi = sprintf('%.2f', $shouyi);
    $yue = sprintf('%.2f', $yue);
    $yiti = sprintf('%.2f', $yiti);

    $this->assign('shouyi', $shouyi);
    $this->assign('yue', $yue);
    $this->assign('yiti', $yiti);
    $this->assign('list', $list);
    $this->assign('page', $show);
    $this->display();
  }

  //充值记录
  public function rechargelog()
  {
    $username = session('username');
    $Dao = new Model();
    $list = $Dao->query("select * from codepay_order where pay_id=$username and status = 2");

    $this->assign('list', $list);

    $this->display();
  }

  //
  public function onlinerecharge()
  {
    $username = session('username');
    $this->assign('username', $username);
    $this->display();
  }


}

?>