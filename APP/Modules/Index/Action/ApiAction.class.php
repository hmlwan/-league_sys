<?php

/**
 * API
 */
class ApiAction extends Action
{
  public function notify()
  {
    //require_once("./sdk/epay.config.php");
      $out_trade_no = $_GET['out_trade_no'];
      $trade_no = $_GET['trade_no'];
      $trade_status = $_GET['trade_status'];
      $type = $_GET['type'];

      if ($_GET['trade_status'] == 'TRADE_SUCCESS') {
        $uid = M('pay')->where(array('pay_no' => $out_trade_no))->find()['pay_id'];//支付用户
        $order_no = $out_trade_no;//订单号
        $me_pri = $_GET['money'];//平台订单的金额,
        $data['status'] = 1;
        $info = M('member')->where(array('username' => $uid))->find();
        $udata['money'] = $info['money'] + $me_pri;
        M('member')->where(array('username' => $uid))->save($udata);
        M('pay')->where(array('pay_no' => $order_no))->save($data);
        echo "success";
      }else {
      echo "fail";
    }
  }
    /*订单自动返利*/
    public function auto_rebate_order(){

        $MemberRebateOrder = D('MemberRebateOrder');
        //失效时间
        $rebate_invalid_days = getConf('rebate_invalid_days');
        //积分有效期
        $rebate_valid_days = getConf('rebate_valid_days');
        //一级返利
        $rebate_rate_1 = getConf('rebate_rate_1');
        $rebate_day_1 = getConf('rebate_day_1');
        //二级返利
        $rebate_rate_2 = getConf('rebate_rate_2');
        $rebate_day_2 = getConf('rebate_day_2');

        $rebate_all = $MemberRebateOrder->getAllOrder(array(
            'status' => array('in',array(0,1,2)),
            'is_receive' => 0
        ));
        $RebateOnlineOrder = D('RebateOnlineOrder');
        $rebate_invalid_second = $rebate_invalid_days * 24*3600;
        if($rebate_all){
            foreach ($rebate_all as $rebate){
                $x = time() - $rebate['add_time'];
                if( $x > $rebate_invalid_second){ //失效
                    $MemberRebateOrder
                        ->where(array('id'=>$rebate['id']))
                        ->save(array('status'=>3));
                }else{
                    //更新内容
                    $online_info =  $RebateOnlineOrder->get_info($rebate['scene'],$rebate['order_no']);
                    if($online_info){
                        $add_data['img'] = $online_info['img'];
                        $add_data['title'] = $online_info['title'];
                        $add_data['order_time'] = $online_info['order_time'];
                        $add_data['commission'] = $online_info['commission'];
                        $add_data['price'] = $online_info['price'];
                        $add_data['status'] = $online_info['status'];
                        $add_data['num'] = $online_info['num'];

                        $MemberRebateOrder->saveInfo(array('id'=>$rebate['id']),$add_data);
                        if($add_data['status'] == 2){ //已结算
                            //订单返利 明细
                            D('UserEcoLog')->changeUserNum($rebate['user_id'],array(
                                'num' => $rebate['num'],
                                'remark' => '订单奖励'.$rebate['num'].'生态积分',
                                'type'=> 5,
                                'valid_period' => $rebate_valid_days
                            ));
                            $MemberRebateOrder->saveInfo(
                                array('id' => $rebate['id']),
                                array('is_receive' => 1,'receive_time'=>time()));
                            //一级返利
                            $member = D('Member');
                            $invite_record_m = D('InviteRecord');
                            $info = $member->getByUserId($rebate['user_id']);
                            if($info['parent_id'] >0 ){
                                $info_1 = $member->getByUserId($info['parent_id']);
                                if($info_1 && $info_1['is_cert'] == 1){
                                    $cert_reward_1 = $rebate_rate_1 * $rebate['num'];
                                    $invite_record_1 = $invite_record_m->addRecord(array(
                                        'user_id' => $info_1['id'],
                                        'num' => $cert_reward_1,
                                        'sub_user_id' => $info['id'],
                                        'add_time' => time(),
                                        'is_cert' => 2,
                                        'sub_mobile' => $info['mobile'],
                                        'level' => 1,
                                        'content' => "一级下线订单返利{$cert_reward_1}生态积分",
                                        'types' => 2
                                    ));
                                    if($cert_reward_1 > 0){
                                        /*明细*/
                                        D('UserEcoLog')->changeUserNum($info_1['id'],array(
                                            'num' => $cert_reward_1,
                                            'remark' => '一级下线订单返利'.$cert_reward_1.'生态积分',
                                            'type'=> 6,
                                            'valid_period' => $rebate_day_1?$rebate_day_1:9999
                                        ));
                                    }

                                    if($info_1['parent_id'] >0){
                                        $info_2 = $member->getByUserId($info_1['parent_id']);
                                        if($info_2 && $info_2['is_cert'] == 1){
                                            $cert_reward_2 = $rebate_rate_2 * $rebate['num'];
                                            $invite_record_2 = $invite_record_m->addRecord(array(
                                                'user_id' => $info_2['id'],
                                                'num' => $cert_reward_2,
                                                'sub_user_id' => $info['id'],
                                                'add_time' => time(),
                                                'is_cert' => 2,
                                                'sub_mobile' => $info['mobile'],
                                                'level' => 2,
                                                'content' => "二级下线订单返利{$cert_reward_2}生态积分",
                                                'types' => 2
                                            ));
                                            if($cert_reward_2 > 0){
                                                /*明细*/
                                                D('UserEcoLog')->changeUserNum($info_2['id'],array(
                                                    'num' => $cert_reward_2,
                                                    'remark' => '二级下线订单返利'.$cert_reward_2.'生态积分',
                                                    'type'=> 6,
                                                    'valid_period' => $rebate_day_2 ? $rebate_day_2:9999
                                                ));
                                            }
                                        }
                                    }
                                }
                            }


                        }
                    }

                }
            }
        }
    }
    /**
     * @param $data
     * 订单超时处理
     */
    public function op_times_out_orders(){
        $order_m = D('Orders');
        $user_m = D('Member');
        $uml_m = D('UserAneLog');

        //买家打款时间(小时)
        $trade_buyer_pay_hours = C('trade_pay_overtime');
        //卖家处理时间(小时)
        $trade_saler_deal_hours = C('trade_sk_overtime');
        //投诉卖家处理时间（小时）
//        $trade_complain_saler_deal_hours = Config::getValue('trade_complain_saler_deal_hours');
        //交易订单失效时间（小时）
//        $trade_order_invalid_hours = C('trade_valid_period');

        $o_w['status'] = array('in',array(2,3));
//        $o_w['status'] = array('in',array(1,2,3));
        $o_w['types'] = 1;
        $order_list = $order_m->where($o_w)->select();
        if($order_list){
            foreach ($order_list as $order){
                $buy_mobile = $user_m->getUserPhone($order['user_id']);
                if($order['status'] == 1){ //等待匹配
                    //挂单失效
//                    if(time()>($order['create_time'] + $trade_order_invalid_hours * 3600)){
////                        $order_m->where(array('id'=>$order['id']))->delete();
//                        $order_m->saveOrder(array('id'=>$order['id']),array('status'=>5,'expired_time'=>time()));
//                    }
                }elseif ($order['status'] == 2){ //等待付款
                    if(time() > ($order['match_time']+ $trade_buyer_pay_hours * 3600)){ //超时
                        /*卖家退云链*/
                        $re_num = $order['number'] + $order['charge_number'];
                        $r = $uml_m->changeUserNum($order['target_user_id'], [
                            'num' => $re_num,
                            'remark' => '市场卖出退回'.$re_num.'ANE',
                            'type' => 9
                        ], 1);
                        if($r){
                            $order_m->saveOrder(array('id'=>$order['id']),array('status'=>5,'expired_time'=>time()));

                            $mem_info = $user_m->getByUserId($order['user_id']);
                            $trade_refuse_pay_times = $mem_info['trade_refuse_pay_times'] + 1;
                            $save_data = array(
                                'trade_refuse_pay_times' => $trade_refuse_pay_times
                            );
                            if(C('trade_refuse_pay_times') > 0){
                                if($trade_refuse_pay_times >= C('trade_refuse_pay_times') ){
                                    $order_status = -1;
                                    $save_data['order_status'] = $order_status;
                                    /*买家禁止交易*/
                                    $order_m->saveOrder(array('user_id' => $order['user_id'],'status'=>1),
                                        array('status' => 5,'expired_time'=>time()));//下架所有挂单
                                }
                            }

                            $user_m->saveInfo($order['user_id'],$save_data);
                            //发短信
//                             $content = getSMSTemplate('3751466');
//                             sendNewSMS($buy_mobile,$content,0);
                        }
                    }
                }elseif($order['status'] == 3){ //等待确认收款
                    if(time()>($order['pay_time']+$trade_saler_deal_hours * 3600)){ //超时未处理

                        $r = $uml_m->changeUserNum($order['user_id'], [
                            'num' => $order['number'],
                            'remark' => '市场买入'.$order['number'].'ANE',
                            'type' => 7
                        ], 1);
                        if($r){
                            $order_m->saveOrder(array('id'=>$order['id']),array('status'=>4,'finish_time'=>time()));
                            //发短信
//                            $content = getSMSTemplate('3751462');
//                            sendNewSMS($buy_mobile,$content,0);
                        }
                    }
                }elseif($order['status'] == 6){ //订单投诉
//                    if(time()>$order['pay_time']+$trade_saler_deal_hours * 3600){//投诉超时未处理
//
//                    }
                }
            }
        }
    }

    /*积分自动失效*/
    public function auto_jifen_invalid(){
        $UserEcoLog = D('UserEcoLog');
        $jifen_data = $UserEcoLog
            ->where(array(
                    'types'=> array('in',array(2,3,5,6)),
                    'valid_period' => array('neq',9999) //永久
                )
            )
            ->select();
        if($jifen_data){
            foreach ($jifen_data as $jifen){
                if( $jifen['valid_period'] != 0 &&
                    (time() - $jifen['create_time'])>($jifen['valid_period'] * 3600 * 24)){ //非永久。到时间自动过期
                    //积分过期 明细
                    D('UserEcoLog')->changeUserNum($jifen['user_id'],array(
                        'num' => $jifen['num'],
                        'remark' => '积分过期'.$jifen['num'].'生态积分',
                        'type'=> 4,
                        'valid_period' => 9999
                    ),-1);
                }
            }
        }
        //退租
        $re_where['is_run'] = 0;
        $list = D('Product')->getProductRecord($re_where);
        $compute_m = D("Compute");
        if($list){
            foreach ($list as $k=>$value){
                $period = $value['period'] * 24 * 3600;
                $left_day = ($period + $value['add_time']) - time() ;
                if ($left_day > 0) {
                } else {//可退租
                    $compute_m->do_rehire($value);

                }
            }
        }
    }
}