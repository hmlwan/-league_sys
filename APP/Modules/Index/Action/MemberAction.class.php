<?php

//消息相关控制器
Class MemberAction extends CommonAction
{
    public function index(){
        $member = M('member');
        $username = session('username');
        $m_info = $member->where(array('username' => $username))->find();

        $this->assign('m_info',$m_info);
        $this->display();
    }

    /*修改登录密码*/
    public function edit_pwd(){
        header("Content-type:text/html;charset=utf-8");
        if (IS_POST) {
            $type = I('type','');
            if(!$type){
                $this->ajaxReturn(array('info' => '未知错误!'));
            }
            //验证用户名和密码
            $mobile = $_POST['username'];
            if(!$mobile){
                $this->ajaxReturn(array('info' => '请输入手机号码!'));
            }
            if (!preg_match("/^(1)[0-9]{10}$/", $mobile)) {
                $this->ajaxReturn(array('info' => '手机号码格式不正确!'));
            }
            if (!M('member')->where(array('username' => trim($mobile)))->getField('id')) {
                $this->ajaxReturn(array('info' => '手机号不存在！'));
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
            if($type == 1){
                $data['password'] = $password;
                $toUrl = U('index/index/logout');
            }else{
                $data['trade_password'] = $password;
                $toUrl = '';
            }
            $mem_db  = M('member');
            $r = $mem_db->where(array('username' => $mobile))->save($data);

            $this->ajaxReturn(array('info' => '修改成功！', 'result' => 1, 'toUrl' => $toUrl));
        }else{
            $this->assign('mobile', session('username'));
            $this->display();
        }
    }

    /*修改支付密码*/
    public function edit_trade_pwd(){
        $this->assign('mobile', session('username'));
        $this->display();
    }
    /*公告*/
    public function announce(){
        $announce_m = M('announce');
        $where = array();
        $where['tid'] = 1;
        $count = $announce_m->where($where)->count();
        $Page  = new Page($count,4);
        $list = $announce_m->where($where)
            ->limit ( $Page->firstRow . ',' . $Page->listRows )
            ->order('edittime desc')
            ->select();
        $this->assign('list', $list);
        if(IS_AJAX){
            $data['content'] = $this->fetch('ajax_announce');
            $data['count'] = array(
                'totalRows'=> $count,
                'listRows'=> 4,
            );
            $this->ajaxReturn($data);
        }else{
            $this->display();
        }
    }
    public function help(){
        $this->display();
    }
}

?>