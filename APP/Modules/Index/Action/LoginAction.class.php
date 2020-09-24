<?php

/**
 * 会员前台登录控制器
 */
Class LoginAction extends Action
{

  public function _initialize()
  {
    //判断是否关闭了网站1
    $open_web = C('open_web');
    if (empty($open_web)) {
      $this->open_web_notice = C('open_web_notice');
      $this->display('Index:404');
      exit;
    }
  }

  /**
   * 会员登录视图
   * @return [type] [description]
   */
  public function index()
  {

    if (IS_AJAX) {

      //验证系统是否为开放状态
      if (C('MEMBER_LOGIN') == 'off') {
        $this->ajaxReturn(array('result' => '0', 'info' => '系统暂未开放！'));
      }

      if (I('username') == "" || I('password') == "") {
        $this->ajaxReturn(array('result' => '0', 'info' => '用户名和密码不能为空！'));
      }


      $model_m = M('member');
      //验证用户名和密码
      $member = $model_m->where(array('username' => I('username'), 'password' => I('password', '', 'md5')))->find();
      if (!$member) {
        $this->ajaxReturn(array('result' => '0', 'info' => '用户名或密码错误!'));
      }


      //禁止锁定会员登录
      if ($member['lock']) {
        $this->ajaxReturn(array('result' => '0', 'info' => '您的账号已经被锁定!联系客服'));
      }

      //更新上一次IP和登录时间
      $prologin['preloginip'] = $member['loginip'];
      $prologin['preloginaddress'] = '';
      $prologin['prelogintime'] = $member['logintime'];

      $model_m->where(array('id' => $member['id']))->save($prologin);
      //更新最后一次登录的IP和登录时间
      //$area = $Ip->getlocation(get_client_ip());
      //$area = get_ip_address(get_client_ip());

      $data = array(
        'id' => $member['id'],
        'logintime' => time(),
        'loginip' => '',
        'loginaddress' => ''
      );
      $model_m->save($data);

      //添加登录总次数
      $model_m->where(array('username' => I('username')))->setInc('logincount');
      //保存session
      session('mid', $member['id']);
      session('username', $member['username']);
      session('member', 'memberlogin');

      $remember = I("post.remember", 0, 'intval');
      $mypassword = I('post.password');
      if (!empty($remember)) {
        setcookie('rememberusername', $member['username'], time() + 3600 * 24 * 30);
        setcookie('rememberpassword', $mypassword, time() + 3600 * 24 * 30);

      } else {
        setcookie('rememberusername', null, time() - 3600 * 24 * 30);
        setcookie('rememberpassword', null, time() - 3600 * 24 * 30);

      }

      //添加日志操作
      //$desc = '会员['.session('username').']登录';
      //write_log(session('username'),'member',$desc);
      $this->ajaxReturn(array('result' => '1', 'info' => '登陆成功！', 'toUrl' => U('Index/Member/index')));

    } else {

      $rememberusername = $_COOKIE['rememberusername'];
      $rememberpassword = $_COOKIE['rememberpassword'];
      if (!empty($_COOKIE['rememberusername'])) {
        $rememberusername = $_COOKIE['rememberusername'];
      }
      if (!empty($_COOKIE['rememberpassword'])) {
        $rememberpassword = $_COOKIE['rememberpassword'];
      }
      $shipin = C('shipin');
      $this->assign('shipin', $shipin);
      $this->assign('rememberusername', $rememberusername);
      $this->assign('rememberpassword', $rememberpassword);
      $this->display();
    }
  }

  //修改密码
  public function editPwd()
  {
    header("Content-type:text/html;charset=utf-8");
    if (IS_POST) {
    	
      $model_m = M('member');
      //验证用户名和密码

      $member = $model_m->where(array('username' => I('username'), 'password' => I('post.oldpassword', '', 'md5')))->find();
      $mobile = $_POST['username'];
      if(!$mobile){
          $this->ajaxReturn(array('info' => '请输入手机号码!'));
      }
      if (!preg_match("/^(1)[0-9]{10}$/", $mobile)) {
        $this->ajaxReturn(array('info' => '手机号码格式不正确!'));
      }
      if (!M('member')->where(array('username' => trim($mobile)))->getField('id')) {
        $this->ajaxReturn(array('info' => '手机号不存在，请重新输入！'));
      }
      $code = I('post.code', '');
      if (!$code) {
        $this->ajaxReturn(array('info' => '请输入短信验证码!'));
      }
      $check_code = sms_code_verify($mobile, $code, session_id());
      if ($check_code['status'] != 1) {
        $this->ajaxReturn(array('info' => $check_code['msg']));
      }
      $password = I('post.password', '', 'md5');
      $repassword = I('post.repassword', '', 'md5');
      if ($password != $repassword) {
        $this->ajaxReturn(array('info' => '密码和确认密码不一致！'));
      }
      //开始修改密码
      $data = array();
      $data['password'] = $password;
      M('member')->where(array('username' => $mobile))->save($data);
      $this->ajaxReturn(array('info' => '修改成功！', 'result' => 1, 'toUrl' => U('index')));
    }
    $this->display();
  }

  public function reg()
  {
    $this->display();
  }

  //前台注册
  public function regSempost()
  {

    if (IS_AJAX) {
      import('ORG.Net.IpLocation');// 导入IpLocation类
      $Ip = new IpLocation(); // 实例化类
      $location = $Ip->getlocation(get_client_ip()); // 获取某个IP地址所在的位置


      $parent = I('post.parent', '', 'strval');

      if (empty($parent)) {
        $this->ajaxReturn(array('result' => 0, 'info' => '推荐人不能为空!'));
      }
      $parent = M('member')->where(array('inviteCode' => $parent))->getField('username');
      $data['parent_id'] = M('member')->where(array('username' => $parent))->getField('id');
      $data['parent'] = $parent;

      $data['username'] =  I('post.username', '', 'strval');
      $code = I('post.code', '');

      $data['truename'] = I('post.truename');
      $password = I('post.password', '', 'strval');
	  $repassword = I('post.repassword', '', 'strval');
	  if($password != $repassword){
	  	   $this->ajaxReturn(array('result' => 0, 'info' => '密码不一致'));
	  }

      //验证推荐人信息是否已存在及审核
      if (!M('member')->where(array('username' => $data['parent']))->getField('id')) {
        $this->ajaxReturn(array('result' => 0, 'info' => '邀请码不存在'));
      }
      if (empty($data['username'])) {
        $this->ajaxReturn(array('result' => 0, 'info' => '请填写手机号码!'));
      }

      if (!preg_match("/^1[34578]{1}\d{9}$/", $data['username'])) {
        $this->ajaxReturn(array('result' => 0, 'info' => '手机号码格式不正确!'));
      }

      if (M('member')->where(array('username' => trim($data['username'])))->getField('id')) {
        $this->ajaxReturn(array('result' => 0, 'info' => '该用户已存在，请更换！'));
      }


      if (!$code) {
        $this->ajaxReturn(array('result' => 0, 'info' => '请输入短信验证码!'));
      }
      $check_code = sms_code_verify($data['username'], $code, session_id());
      if ($check_code['status'] != 1) {
        $this->ajaxReturn(array('result' => 0, 'info' => $check_code['msg']));
      }

      if (empty($password)) {
        $this->ajaxReturn(array('result' => 0, 'info' => '登陆密码不能为空'));
      }

      $hongbao = C('hongbao');
      $data['regaddress'] = $location['country'] . $location['area']; // 所在国家或者地区
      $data['regip'] = get_client_ip(); // 所在国家或者地区
//      $data['idcard'] = I('post.idcard');
      $data['password'] = md5($password);
//      $data['money'] = $hongbao;
      $parentinfo = M('member')->where(array('username' => $data['parent']))->find();
      $data['parentpath'] = trim($parentinfo['parentpath'] . $parentinfo['id'] . '|');;
      $data['parentlayer'] = $parentinfo['parentlayer'] + 1;
      $data['regdate'] = time();
      $inviteCode = $this->checkInviteCode($this->makeCode());
      $data['inviteCode'] = $inviteCode;
      M('member')->add($data);

      //我的上级直推加一
      M('member')->where(array('username' => $data['parent']))->setInc('parentcount', 1);
      mmtjrennumadd($data['parent_id']);//  所有上级加一人
      $this->ajaxReturn(array('result' => 1, 'info' => '注册成功！','toUrl'=>U('index')));
    }
  }

  public function checkInviteCode($code)
  {
    $tmp = M('member')->where(array('inviteCode' => $code))->find();
    if ($tmp) {
        $this->checkInviteCode($this->makeCode());
    } else {
        return $code;
    }
  }

  public function makeCode()
  {
    for ($i = 0, $tmp = ''; $i < 3; $i++) {
      $tmp .= chr(mt_rand(65, 90));
    }
    for ($i = 0, $numTmp = ''; $i < 3; $i++) {
      $numTmp .= mt_rand(0, 9);
    }
    return $tmp . $numTmp;
  }

  /**
   * 生成验证码
   */
  public function verify()
  {
    import('ORG.Util.Image');
    Image::buildImageVerify(4, 1, 'png', 55, 25);
  }

  public function showcode()
  {
    $this->display();
  }

  //验证码验证
  public function checkVerify($code)
  {
    if (session('verify') != $code) {
      alert('验证码错误', -1);
    }
  }

  public function checkUsername($username)
  {
    if (!$id = M('member')->where(array('username' => $username))->getField('id')) {
      alert('您输入的会员账号不存在！', -1);
    } else {
      return $id;
    }
  }


}

?>