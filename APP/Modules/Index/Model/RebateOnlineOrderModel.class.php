<?php
class RebateOnlineOrderModel extends Model
{

    public function get_status($scene){
        switch ($scene) {
            case '1': //淘宝
                return array(
                    '订单付款' => 1,
                    '订单结算' => 2,
                    '订单失效' => 3,
                );
            case '2': //京东
                return array(
                    '16' => 1,
                    '17' => 2,
                    '3' => 3,
                );
            case '3': //拼多多
                return array(
                    '已成团' => 1,
                    '确认收货' => 2,
                    '审核失败' => 3,
                );
            case '4': //苏宁
                return array(
                    '支付完成' => 1,
                    '已收货' => 2,
                    '退款' => 3,
                );
            case '5': //唯品会
                return array(
                    '已付款' => 1,
                    '已结算' => 2,
                    '已失效' => 3,
                );
        }
    }
    public function get_table($scene){

        switch ($scene){
            case '1': //淘宝
                return array(
                    'table' => 'ims_tiger_newhu_tkorder',
                    'order_no' => 'orderid',
                    'img' => 'itempic',
                    'title' => 'title',
                    'order_time' => 'addtime',
                    'commission' => 'xgyg',
                    'price' => 'fkprice',
                    'status' => 'orderzt',
                    );
            case '2': //京东
                return array(
                    'table' => 'ims_tiger_newhu_jdorder',
                    'order_no' => 'orderId',
                    'img' => 'https://p.ssl.qhimg.com/t0154c1e1a23e9b81a4.jpg',
                    'title' => 'skuName',
                    'order_time' => 'orderTime',
                    'commission' => 'estimateCosPrice',
                    'price' => 'price',
                    'status' => 'validCode',
                );
            case '3': //拼多多
                return array(
                    'table' => 'ims_tiger_newhu_pddorder',
                    'order_no' => 'order_sn',
                    'img' => 'goods_thumbnail_url',
                    'title' => 'goods_name',
                    'order_time' => 'order_create_time',
                    'commission' => 'promotion_amount',
                    'price' => 'order_amount',
                    'status' => 'order_status_desc'
                );
            case '4': //苏宁
                return array(
                    'table' => 'ims_tiger_newhu_snorder',
                    'order_no' => 'orderCode',
                    'img' => 'pictureurl',
                    'title' => 'productname',
                    'order_time' => 'orderSubmittime',
                    'commission' => 'prepaycommission',
                    'price' => 'payAmount',
                    'status' => 'orderlinestatusdesc'
                );
            case '5': //唯品会
                return array(
                    'table' => 'ims_tiger_newhu_wphorder',
                    'order_no' => 'order_sn',
                    'img' => 'goodsThumb',
                    'title' => 'goodsName',
                    'order_time' => 'orderTime',
                    'commission' => 'commission',
                    'price' => 'commissiontotalcost',
                    'status' => 'orderSubStatusName'
                );
        }
    }

    public function get_info($scene,$no){

        $rebate_rate = getConf('rebate_rate');
        $conf = $this->get_table($scene);

        $table = $conf['table'];
        $order_no = $conf['order_no'];
        $data = array();
        $info = M($table,' ',C('DB_REBATE_ORDER'))->where(array($order_no =>$no))->find();
        if($info){
            $data['order_no'] =  $info[$conf['order_no']];
            $data['img'] =  $info[$conf['img']];
            $data['title'] =  $info[$conf['title']];
            $data['order_time'] =  $info[$conf['order_time']];
            $data['commission'] =  $info[$conf['commission']];
            $data['num'] =  set_number($data['commission'] * $rebate_rate,2);
            $data['price'] =  $info[$conf['price']];
            $get_status = $this->get_status($scene);
            $status = $get_status[$info[$conf['status']]];
            $data['status'] = $status ? $status : 0 ;
        }
        return $data;
    }
}