<?php

/**
 * Created by PhpStorm.
 * Date: 2020/10/8
 * Time: 21:21
 */
class TradeAction extends CommonAction{
    public function _initialize()
    {
        $user_id = session('mid');
        $member_senior_info = M('member_senior_cert')->where(array('user_id'=>$user_id))->find();

        if($member_senior_info['is_senior_cert'] != 1){
            $this->redirect('index/member/senior_cert');
        }
    }
    /*交易大厅*/
    public function index(){
        $trade_is_stop = C('trade_is_stop');
        $trade_stop_reason = C('trade_stop_reason');
        $trade_start_receive = C('trade_start_receive');
        $trade_end_receive = C('trade_end_receive');
        $tips = '';
        $is_trade = 1;
        $is_over_time = 0;
        if($trade_is_stop == 1){
            $tips = $trade_stop_reason;
            $is_trade = 0;
        }
        if(time()< strtotime($trade_start_receive) || time() > strtotime($trade_end_receive) ){
            $tips = "交易时间为：{$trade_start_receive}-{$trade_end_receive}";
            $is_over_time = 1;
        }

        $user_id = session('mid');
        $member = D('Member');
        $info = $member->getByUserId($user_id);
        $is_skm = 0;
        if($info['wx'] || $info['zfb']){
            $is_skm = 1;
        }
        $member_league = M('member_league')->where(array('user_id'=>$user_id))->find();
        $sxf_rate = $member_league['sxf_rate'];
        $get_k = $this->get_k();
        $k_line_arr = array_values($get_k);

        $data = array(
            'is_trade'=> $is_trade,
            'is_skm'=> $is_skm,
            'is_over_time'=> $is_over_time,
            'tips'=> $tips,
            'sxf_rate'=> $sxf_rate,
            'k_line_arr'=> $k_line_arr,
            'times'=> date("Y-m-d",time()),
        );
        $this->assign($data);
        $this->display();
    }
    public function get_k(){
        $k_line = M('k_line')->order('add_time desc')->select();
        $k_line_arr = array();
        foreach ($k_line as $value){
            $k_line_arr[date("m-d",$value['add_time'])] = $value['price'];
        }
        $k_line_arr = array_slice($k_line_arr,0,7);
        return $k_line_arr;
    }
    public function get_k_data(){

        $k_line_arr = $this->get_k();
        $data = array(
            'price'=> array_values($k_line_arr),
            'date'=> array_keys($k_line_arr),
        );
        $this->ajaxReturn($data);
    }
    /*求购中心*/
    public function buy(){
        $model = D("Orders");
        $user_id = session('mid');
        $page   = I('get.page', 1);
        $limit  = I('get.limit', 7);
        $data  = $model->getList($model::TYPE_BUY, $user_id, $page, $limit);
        $count = $data['total'];
        $list = $data['list'];
        if($list){
            foreach ($list as &$value){
                $value['sk_way_arr'] = explode(',',$value['sk_way']);
            }
        }
        $this->assign('list', $list);
        if(IS_AJAX){
            $data['content'] = $this->fetch('ajax_buy');
            $data['count'] = array(
                'totalRows'=> $count,
                'listRows'=> 7,
            );
            $this->ajaxReturn($data);
        }else{
            $this->display();
        }
    }
    //是否休市
    public function is_stop_deal(){
        $trade_start_receive = C('trade_start_receive');
        $trade_end_receive = C('trade_end_receive');
        $is_stop_deal = 1;
        if((time()>=strtotime($trade_start_receive)) && time()<=strtotime($trade_end_receive)){
            $is_stop_deal = 0;
        }
        return $is_stop_deal;
    }
    /*发布求购*/
    public function publish(){

        $trade_price = C('trade_price');
        $this->assign('trade_price',$trade_price);
        $this->display();
    }

    /*交易协议*/
    public function agreement(){
        $this->display();
    }

    /**
     * @param Request $request
     * 买入
     */
    public function do_publish(){
        $user_id = session('mid');
        $sk_way = I('post.sk_way');
        $is_read = I('post.is_read');
        $number = I('post.number');
        $price = I('post.price');
        $total_price = I('post.total_price');
        $order_m = D("Orders");
        $trade_buy_limit = C('trade_buy_limit');
        $trade_buy_limit_arr = explode('/',$trade_buy_limit);
        if(!$number){
            $this->ajaxReturn(array('info' => '请输入求购数量！'));
        }
        if($trade_buy_limit_arr){
            if(!in_array($number,$trade_buy_limit_arr)){
                $this->ajaxReturn(array('info' => "求购数量只支持{$trade_buy_limit}数量！"));
            }
        }
        if(!$price){
            $this->ajaxReturn(array('info' => '缺少价格,请联系客服！'));
        }
        if(!$sk_way){
            $this->ajaxReturn(array('info' => '请至少选择一种收款方式！'));
        }
        $member = D('Member');
        $info = $member->getByUserId($user_id);
        $sk_way_arr = explode(',',$sk_way);
        $is_sk_empty = 0;
        $sk_way_field = '';
        foreach ($sk_way_arr as $sk_way_val){
            if(!$info[$sk_way_val]){
                $is_sk_empty = 1;
                $sk_way_field = $sk_way_val;
                break;
            }
        }
        if($is_sk_empty == 1){
            $sk_way_msg = $sk_way_field == 'wx' ? "微信" : '支付宝';
            $this->ajaxReturn(array('info' => "请先去上传{$sk_way_msg}收款方式！",'toUrl'=>U('/index/member/payment')));
        }
        if(!$is_read){
            $this->ajaxReturn(array('info' => '请勾选交易协议！'));
        }
        if($info['order_status'] == -1){
            $this->ajaxReturn(array('info' => '你已被禁止交易！'));
        }
        /*交易时间*/
        $trade_start_receive = C('trade_start_receive');
        $trade_end_receive = C('trade_end_receive');
        if(time()< strtotime($trade_start_receive) || time() > strtotime($trade_end_receive) ){
            $this->ajaxReturn(array('info' => "交易时间为{$trade_start_receive}-{$trade_end_receive}"));
        }
        /*当前挂单数*/
        $buy_w['user_id'] = $user_id;
        $buy_w['status'] = $order_m::STATUS_DEFAULT;
        $buy_list = $order_m->where($buy_w)->select();
        $buy_count = count($buy_list);
        $trade_running_orders = C('trade_running_num');
        if($buy_count >=  $trade_running_orders){
            $this->ajaxReturn(array('info' => "最多同时能挂{$trade_running_orders}单"));
        }
        //进行购买
        $r = $order_m->add_order($user_id,array(
            'price' => $price,
            'number' => $number,
            'type' => $order_m::TYPE_BUY,
            'total_price' => $total_price,
            'sk_way' => $sk_way,
        ));
        if(!$r){
            $this->ajaxReturn(array('info' => '发布失败！'));
        }
        $this->ajaxReturn(array('info' => "发布成功！", 'result' => 1, 'toUrl' => U('/index/trade/publish')));
    }


    /**
     * 出售
     */
    public function do_sale(){
        $user_id = session('mid');
        $order_m = D("Orders");
        $user_m = D("Member");
        $orderId = I('post.order_id',0,'intval');

        $order = $order_m->getOneById($orderId);
        if(!$order || $orderId <= 0){
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        $trade_is_stop = C('trade_is_stop');
        $trade_stop_reason = C('trade_stop_reason');
        if($trade_is_stop == 1){
            $this->ajaxReturn(array('info' => $trade_stop_reason));
        }
        try {
            $order_m->checkSaleTa($orderId, $user_id);
        } catch (\Exception $e) {
            $this->ajaxReturn(array('info' =>$e->getMessage()));
        }
        $user_info = $user_m->getByUserId($user_id);
        $order_status = $user_info['order_status'];
        if($order_status == -1){
            $this->ajaxReturn(array('info' => '你已被禁止交易！'));
        }

        $sk_way_arr = explode(",",$order['sk_way']);
        $is_empty_sk_way = 1;
        foreach ($sk_way_arr as $sk_way){
            if($user_info[$sk_way]){
                $is_empty_sk_way = 0;
            }
        }
        if($is_empty_sk_way == 1){
            $this->ajaxReturn(array('info' => '完成支付宝微信收款码绑定才能解锁该页面！','toUrl'=>U('/index/member/payment')));
        }
        /*手续费*/
        $charge_number = 0;
        $member_league = M('member_league')->where(array('user_id'=>$user_id))->find();
        if($member_league['sxf_rate'] > 0){
            $charge_number = $order['number'] * $member_league['sxf_rate'];
        }
        $charge_number = set_number($charge_number,2);

        //卖ta
        $result = $order_m->saleTa($orderId, $user_id,$charge_number,$member_league['sxf_rate']);
        if ($result) {
            //发短信
            $buy_mobile = $user_m->where(array('id'=>$order['user_id']))->getField('username');
            $content = getSMSTemplate('3751472');
//            sendNewSMS($buy_mobile,$content,0);
            $this->ajaxReturn(array('info' => '出售成功！', 'result' => 1,'toUrl'=>U('/index/trade/record')));
        }
        $this->ajaxReturn(array('info' => '出售失败！'));
    }


    /*我的订单*/
    public function order(){
        $order_m = D("Orders");
        $user_id = session('mid');

        //买入中
        $w = array(
            'user_id' => $user_id,
            'types' => $order_m::TYPE_BUY,
            'status' => $order_m::STATUS_DEFAULT,
        );
        $count = $order_m->where($w)->count();

        $Page  = new Page($count,7);
        $list = $order_m
            ->where($w)
            ->limit ( $Page->firstRow . ',' . $Page->listRows )
            ->order('create_time desc')
            ->select();
        if($list){
            foreach ($list as &$value){
                $value['sk_way_arr'] = explode(',',$value['sk_way']);
            }
        }
        $this->assign('list', $list);
        if(IS_AJAX){
            $data['content'] = $this->fetch('ajax_order');
            $data['count'] = array(
                'totalRows'=> $count,
                'listRows'=> 7,
            );
            $this->ajaxReturn($data);
        }else{
            $this->display();
        }
    }
    /**
     * 取消
     */
    public function cancel(){

        $type = "buy";
        $id = I('post.order_id');
        $order_m = D("Orders");
        $user_id = session('mid');

        $order = $order_m->getOneById($id);

        if (!$order) {
            $this->ajaxReturn(array('info' => '对象不存在！'));
        }
        if ($order['user_id'] != $user_id) {
            $this->ajaxReturn(array('info' => '请求错误！'));
        }
        if ($order['status'] != $order_m::STATUS_DEFAULT) {
            $this->ajaxReturn(array('info' => '订单已在交易中，请在交易中去继续操作！'));
        }

        switch ($type) {
            case 'buy':
                $result = $order_m->cancelBuy($order);
                break;
            case 'sale':
                $result = $order_m->cancelSale($order);
                break;
            default:
                $this->ajaxReturn(array('info' => '请求错误！'));
        }
        if ($result) {
            $this->ajaxReturn(array('info' => '取消成功！', 'result' => 1,'toUrl'=>U('/index/trade/buy')));
        }
        $this->ajaxReturn(array('info' => '取消失败！'));
    }
    /*交易记录*/
    public function record(){
        $order_m = D("Orders");
        $user_id = session('mid');

        $buy = $order_m->getBuyList($user_id);
        $limit = I('get.limit',7);
        $page = I('get.p', 1);

        $p = ($page-1)*$limit;
        $buy1 = array_slice($buy,$p,$limit);

        $order_status = 1;
        if($buy1){
            if($buy1[0]['order_status'] == -1){
                $order_status = -1;
            }
        }
        if($buy1){
            foreach ($buy1 as &$value){
                $value['sk_way_arr'] = explode(',',$value['sk_way']);
            }
        }
        $this->assign('list', $buy1);
        if(IS_AJAX){
            $data['content'] = $this->fetch('ajax_record');
            $data['count'] = array(
                'totalRows'=> count($buy),
                'listRows'=> 7,
            );
            $this->ajaxReturn($data);
        }else{
            $this->display();
        }
    }
    /**
     * @param Request $request
     * @return mixed
     * 完成订单
     */
    public function finish(){
        $user_id = session('mid');
        $order_m = D("Orders");
        $finish = $order_m->getFinishList($user_id);

        $limit = I('get.limit',7);
        $page = I('get.p', 1);

        $p = ($page-1)*$limit;
        $finish1 = array_slice($finish,$p,$limit);

        if($finish1){
            foreach ($finish1 as &$value){
                $value['sk_way_arr'] = explode(',',$value['sk_way']);
            }
        }
        $this->assign('list', $finish1);
        if(IS_AJAX){
            $data['content'] = $this->fetch('ajax_finish');
            $data['count'] = array(
                'totalRows'=> count($finish),
                'listRows'=> 7,
            );
            $this->ajaxReturn($data);
        }else{
            $this->display();
        }
    }
    /**
     * 买家详情
     */
    public function buy_detail(){
        $order_id = I('get.order_id');
        $order_m = D("Orders");
        $user_id = session('mid');
        $info = $order_m->getOneById($order_id);
        $user_m = D("Member");

        $sale_info = $user_m->getByUserId($info['target_user_id']);
        if(empty($info) || empty($sale_info)|| $info['user_id'] != $user_id){
            $this->redirect('/index/trade/record');
        }
        $status = $info ['status'];
        $left_time = 0;
        if($status == 2){//付款剩余时间
            //买家打款时间(小时)
            $trade_buyer_pay_hours = C('trade_pay_overtime');
            $left_time = ($trade_buyer_pay_hours*3600)-(time()- $info['match_time']);
        }
        if($status == 3){ //卖家处理时间
            $trade_saler_deal_hours = C('trade_pay_overtime');
            $left_time = ($trade_saler_deal_hours*3600)-(time()- $info['pay_time']);
        }
        if($status == 6){ //投诉卖家处理时间
            $trade_complain_saler_deal_hours = C('trade_complain_saler_deal_hours');
            $left_time = ($trade_complain_saler_deal_hours*3600)-(time()- $info['report_time']);
        }
        if($left_time<0){
            $left_time = 0;
        }
        $show_left_time_str = '';
        if($left_time > 0){
            $left_time_arr = transToSecond($left_time);
            $show_left_time_str = $left_time_arr['a'].'小时'.$left_time_arr['b'].'分钟'.$left_time_arr['c'].'秒';
            $show_left_time_str = "'{$show_left_time_str}'";
        }
        $data_view = array(
            'info' => $info,
            'sale_info' => $sale_info,
            'left_time'=>$left_time,
            'show_left_time_str' =>  $show_left_time_str?$show_left_time_str:"'00小时00分钟00秒'"
        );
        $this->assign($data_view);
        $this->display();
    }
    /**
     * 卖家详情
     */
    public function sale_detail(){
        $order_id = I('get.order_id');
        $order_m = D("Orders");
        $user_id = session('mid');
        $info = $order_m->getOneById($order_id);

        $user_m = D("Member");
        //卖家信息
        $buy_info =  $user_m->getByUserId($info['user_id']);
        if(empty($info)|| empty($buy_info) || $info['target_user_id'] != $user_id){
            $this->redirect('/index/trade/record');
        }
        $status = $info['status'];

        $left_time = 0;
        if($status == 2){//付款剩余时间
            //买家打款时间(小时)
            $trade_buyer_pay_hours = C('trade_pay_overtime');
            $left_time = ($trade_buyer_pay_hours * 3600)-(time()- $info['match_time']);
        }
        if($status == 3){ //卖家处理时间
            $trade_saler_deal_hours = C('trade_pay_overtime');
            $left_time = ($trade_saler_deal_hours * 3600)-(time()- $info['pay_time']);
        }
        if($status == 6){ //投诉卖家处理时间
            $trade_complain_saler_deal_hours = C('trade_complain_saler_deal_hours');
            $left_time = ($trade_complain_saler_deal_hours * 3600)-(time()- $info['report_time']);
        }
        if($left_time<0){
            $left_time = 0;
        }
        $show_left_time_str = '';
        if($left_time>0){
            $left_time_arr = transToSecond($left_time);
            $show_left_time_str = $left_time_arr['a'].'小时'.$left_time_arr['b'].'分钟'.$left_time_arr['c'].'秒';
            $show_left_time_str = "'{$show_left_time_str}'";
        }
        $data_view = array(
            'info' => $info,
            'buy_info' => $buy_info,
            'left_time'=>$left_time,
            'show_left_time_str' =>  $show_left_time_str?$show_left_time_str:"'00小时00分钟00秒'"
        );
        $this->assign($data_view);
        $this->display();

    }
    /**
     * 确定付款
     */
    public function pay(){

        $id = I('post.order_id');
        $image = I('post.image');
        $order_m = D("Orders");
        $user_id = session('mid');
        $order = $order_m->getOneById($id);
        if (!$order) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        if ($order['user_id'] != $user_id) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        if (empty($image)) {
            $this->ajaxReturn(array('info' => '请先上传打款凭据截图！'));
        }
        $save_data = array(
            'status' => $order_m::STATUS_CONFIRM,
            'pay_time' => time(),
            'image' => $image,
        );
        $r = $order_m->saveOrder(array('id'=>$id),$save_data);
        if ($r) {
            //恶意不付款清0
            M("member")->where(array('id'=>$user_id))->save(array('trade_refuse_pay_times'=>0));
            $this->ajaxReturn(array('info' => '付款成功！', 'result' => 1));
        }
        $this->ajaxReturn(array('info' => '操作失败，请联系管理员处理！'));
    }
    /**
     * 确定已收款
     */
    public function confirm(){

        $id = I('post.order_id');
        $order_m = D("Orders");
        $user_id = session('mid');
        $order = $order_m->getOneById($id);

        if (!$order) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        if ($order['target_user_id'] != $user_id) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        /*if ($order->status != Orders::STATUS_PAY) {
            return json(['code' => 1, 'message ' => '操作错误']);
        }*/
        //是否首次交易成功
        $trade_succuss_w = array(
            'user_id' => $order['user_id'],
            'status' => 4,
        );
//        $trade_succuss_info = Orders::get($trade_succuss_w);

        $save_data = array(
            'status' => $order_m::STATUS_FINISH,
            'finish_time'=> time()

        );
        $r = $order_m->saveOrder(array('id'=>$id),$save_data);
        $userAneLog_m = D('UserAneLog');
        if ($r) {
            //发短信
            $number = $order['number'];
            $res = $userAneLog_m->changeUserNum($order['user_id'], [
                'num' => $number,
                'remark' => '市场买入'.$number.'ANE',
                'type' => 7
            ], 1);
            if(!$res){
                $this->ajaxReturn(array('info' => '收款失败！'));
            }
//            if(empty($trade_succuss_info)){
//                $user_entity = User::getUserInfo($order->user_id);
//                Auth::addTradeInviteRecord($user_entity);
//            }
            $this->ajaxReturn(array('info' => '收款成功！', 'result' => 1,'toUrl' => U('/index/trade/finish')));
        }
        $this->ajaxReturn(array('info' => '操作失败，请联系管理员处理！'));

    }
    /*我要举报*/
    public function report(){
        $user_id = session('mid');
        $id = I('post.order_id',0,'intval');
        $order_m = D("Orders");
        $user_m = D("Member");
        $order = $order_m->getOneById($id);
        if (!$order) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        if ($order['target_user_id'] != $user_id) {
            $this->ajaxReturn(array('info' => '未知错误！'));
        }
        /*if ($order->status != Orders::STATUS_PAY) {
            return json(['code' => 1, 'message ' => '操作错误']);
        }*/
        $save_data = array(
            'status' => $order_m::STATUS_COMPLAIN,
            'report_time' => time(),
        );

        $r = $order_m->saveOrder(array('id'=>$id),$save_data);

        if ($r) {
            //发短信
//            $buy_mobile = User::getUserPhone($order->user_id);
//            $content = getSMSTemplate('3751468');
//            sendNewSMS($buy_mobile,$content,0);
            $this->ajaxReturn(array('info' => '举报成功！', 'result' => 1));
        }
        $this->ajaxReturn(array('info' => '操作失败，请联系管理员处理！'));
    }
}