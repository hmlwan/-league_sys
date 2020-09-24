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
}