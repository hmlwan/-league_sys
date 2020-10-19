<?php


class OrdersModel extends Model
{
    const TYPE_BUY = 1; //买入订单
    const TYPE_SALE = 2; //卖出订单

    const STATUS_DEFAULT = 1; //加入订单
    const STATUS_PAY = 2; //等待付款
    const STATUS_CONFIRM = 3; //等待确认付款
    const STATUS_FINISH = 4; //订单完成
    const STATUS_CONCALL = 5; //订单失效
    const STATUS_COMPLAIN = 6; //订单投诉

    public function getStatus($status)
    {
        switch ($status) {
            case self::STATUS_DEFAULT:
                return '等待匹配';
            case self::STATUS_PAY:
                return '等待付款';
            case self::STATUS_CONFIRM:
                return '等待收款';
            case self::STATUS_FINISH:
                return '交易完成';
            case self::STATUS_CONCALL:
                return '订单失败';
            case self::STATUS_COMPLAIN:
                return '投诉中';
            default:
                return '';

        }
    }
    public function getOneById($id){

        return $this->where(array('id'=>$id))->find();
    }
    public function saveOrder($where,$data){
        return $this->where($where)->save($data);
    }
    /**
     * 买入取消
     */
    public function cancelBuy($order)
    {
        return $this->saveOrder(array('id'=>$order['id']),array(
            'status'=>5,
            'expired_time'=>time())
        );
    }
    /**
     * 获取列表
     */
    public function getList($type, $userId, $page = 1, $limit = 20)
    {

        $orderTable = "ds_orders";
        $userTable = "ds_member";
        $trade_is_sort = C('trade_is_sort');
        $trade_valid_period = C('trade_valid_period');
        $finishStatus = $this::STATUS_FINISH;
        $defaultStatus = $this::STATUS_DEFAULT;

        $offset = ($page - 1) * $limit;

        $sql = <<<SQL
SELECT o.*,u.username as mobile,u.order_status,u.trade_refuse_pay_times,
(SELECT count(*) FROM {$orderTable} where user_id = o.user_id and status = {$finishStatus} limit 1) as finish
FROM {$orderTable} as o LEFT JOIN {$userTable} as u ON o.user_id=u.id WHERE o.status ={$defaultStatus} AND
o.types={$type} AND user_id<>{$userId}
SQL;
        if ($trade_valid_period > 0) {
            $cur_time = time() - $trade_valid_period * 3600;
            $sql .= " AND u.logintime>{$cur_time} ";
        }

        $count_sql = <<<SQL
SELECT count(*) as total FROM {$orderTable} as o LEFT JOIN {$userTable} as u ON o.user_id=u.id WHERE o.status ={$defaultStatus} AND
o.types={$type} AND user_id<>{$userId}
SQL;
        if ($trade_valid_period > 0) {
            $cur_time = time() - $trade_valid_period*3600;
            $count_sql .= " AND u.logintime>{$cur_time} ";
        }
        $total = $this->query($count_sql);

        if($trade_is_sort == 1){
            $sql .= " ORDER BY RAND() limit {$offset},{$limit} ";
        }else{
            $sql .= " ORDER BY o.create_time DESC limit {$offset},{$limit} ";
        }

        $list = $this->query($sql);

        return array(
            'total'=>$total[0]['total']?$total[0]['total']:0,
            'list'=>$list
        );
    }

//获取用户交易中的买入订单
    public function getBuyList($userId)
    {
        //买入订单(user_id = 自己 types为1 或者 target_user_id = 自己 types=2)

        $tableName = "ds_orders";
        $buyType = $this::TYPE_BUY;
//        $saleType = orders::TYPE_SALE;
        $saleType = $this::TYPE_BUY;
        $status = $this::STATUS_PAY . ',' . $this::STATUS_CONFIRM.',' . $this::STATUS_COMPLAIN;
        $sql = <<<SQL
SELECT * from {$tableName} WHERE (user_id = {$userId} AND types={$buyType} AND status in ({$status}))
OR (target_user_id = {$userId} AND types={$saleType} AND status in ({$status})) ORDER BY create_time desc
SQL;
        $list = $this->query($sql);
        foreach ($list as &$value){
            if($value['user_id'] ==$userId){
                $value['types'] = 1;
            }elseif ($value['target_user_id'] ==$userId){
                $value['types'] = 2;
            }
            $order_status = M('member')->where(array('id'=>$userId))->getField('order_status');
            $value['order_status'] = $order_status;
        }
        return $list;
    }



    protected function setOrderNumber($memberId)
    {
        return date('Ymd') . $memberId . date('His');
    }

    public function add_order($userId,$data)
    {
        $add_data = array();
        $add_data['order_number'] = $this->setOrderNumber($userId);
        $add_data['user_id'] = $userId;
        $add_data['number'] = $data['number'];
        $add_data['price'] = $data['price'];
        $add_data['create_time'] = time();
        $add_data['status'] = $this::STATUS_DEFAULT;
        $add_data['types'] = $data['type'];
        $add_data['total_price'] = $data['total_price'];
        $add_data['sk_way'] = $data['sk_way'];

        $result = $this->add($add_data);
        if ($result) {
            return true;
        }
        return false;

    }

    public function getChargeNumber($number)
    {
        $rate = Config::getValue('market_sys_rate');
        return bcmul($number, $rate, 8) / 100;
    }

    /**
     * 确定已收款
     */
    public function confirm()
    {
        $userId = $this->types == self::TYPE_BUY ? $this->user_id : ($this->types == self::TYPE_SALE ? $this->target_user_id : 0);
        if (!$userId) {
            return false;
        }

        Db::startTrans();
        try {
            //添加用户的魔石
            $user = User::where('id', $userId)->find();
            $old = $user->magic;
            $change = bcadd($old, $this->number, 8);
            $new = $change;
            $user->magic = $new;

            if (!$user->save()) {
                throw new \Exception('操作失败');
            }

            //写入日志
            $model = new UserMagicLog();
            $result = $model->addInfo($userId, '买入交易成功', $this->number, $old, $new, UserMagicLog::TYPE_ORDER);
            if (!$result) {
                throw new \Exception('操作失败');
            }

            //修改订单状态
            $this->status = Orders::STATUS_FINISH;
            $this->finish_time = time();

            if (!$this->save()) {
                throw new \Exception('操作失败');
            }

            Db::commit();

            return true;

        } catch (\Exception $e) {
            Db::rollback();

            return true;
        }
    }

    /**
     * 取消交易中的订单
     */
    public function cancel()
    {
        $userId = $this->types == self::TYPE_BUY ? $this->target_user_id : ($this->types == self::TYPE_SALE ? $this->user_id : 0);
        if (!$userId) {
            return false;
        }

        Db::startTrans();
        try {
            //返回用户的魔石的手续费
            $user = User::where('id', $userId)->find();
            $old = $user->magic;
            $change = bcadd($this->number, $this->charge_number, 8);
            $new = bcadd($old, $change, 8);
            $user->magic = $new;

            if (!$user->save()) {
                throw new \Exception('操作失败');
            }

            //写入日志
            $model = new UserMagicLog();
            $result = $model->addInfo($userId, '出售交易取消', $change, $old, $new, UserMagicLog::TYPE_ORDER);
            if (!$result) {
                throw new \Exception('操作失败');
            }

            //删除订单
            if (!$this->delete()) {
                throw new \Exception('操作失败');
            }

            Db::commit();

            return true;

        } catch (\Exception $e) {
            Db::rollback();

            return true;
        }
    }



    /**
     * 卖ta
     */
    public function saleTa($orderId, $userId,$charge_number)
    {
        $order = $this->getOneById($orderId);;
        $member_m = D("Member");

        $userInfo = $member_m->getByUserId($userId);
        if (!$userInfo) {
            return false;
        }
        $model = D('UserAneLog');
        $num = $order['number'] + $charge_number;
        $result = $model->changeUserNum($userId, [
            'num' => $num,
            'remark' => '市场卖出'.$num.'ANE',
            'type'=> 8,
        ], -1);

        if ($result) {
            $save_data = array(
                'status' => $this::STATUS_PAY,
                'target_user_id' => $userId,
                'charge_number' => $charge_number,
                'match_time' => time(),
            );
            $this->saveOrder(array('id'=>$orderId),$save_data);

            return true;
        }

        return false;
    }
    /**
     * 卖ta 验证
     */
    public function checkSaleTa($orderId, $userId)
    {
        $member_m = D("Member");
        $order = $this->getOneById($orderId);
        if (!$order || $order['types'] != $this::TYPE_BUY) {
            throw new \Exception('订单已经不存在');
        }
        if ($order['status'] != $this::STATUS_DEFAULT) {
            throw new \Exception('订单已被别人出售了');
        }
        if ($order['user_id'] == $userId) {
            throw new \Exception('自己的订单不能出售哦');
        }
        $user = $member_m->getByUserId($userId);
        $charge_number = 0;
        /*手续费*/
        $member_league = M('member_league')->where(array('user_id'=>$userId))->find();
        if($member_league['sxf_rate'] > 0){
            $charge_number = $order['number'] * $member_league['sxf_rate'];
        }
        $charge_number = set_number($charge_number,2);

        if (($user['ane']) < bcadd($order['number'], $charge_number, 2)) {
            throw new \Exception(sprintf('ANE数量不足', $charge_number));
        }
        $checkOrder = $this->checkOrder($order['user_id'],$userId);
        if ($checkOrder['ret'] != 0) {
            throw new \Exception($checkOrder['msg']);
        }
    }
    /**
     * 判断用户是否还有交易没完成
     */
    public function checkOrder($userId,$target_user_id)
    {
        $trade_user_whitelist = C('trade_whitelist');

        $trade_user_whitelist_ids = array();
        if($trade_user_whitelist){
            $trade_user_whitelist_ids = array_unique(array_filter(explode(',',$trade_user_whitelist)));
        }
        $w1 = array();
        $w1['user_id|target_user_id'] = $userId;
        $w1['status'] = array('in',[$this::STATUS_PAY, $this::STATUS_CONFIRM, $this::STATUS_COMPLAIN]);

        $total1 = $this->where($w1)
            ->count();
        if($trade_user_whitelist_ids && in_array($target_user_id,$trade_user_whitelist_ids)){
            $total2 = 0;
        }else{
            $w2 = array();
            $w2['user_id|target_user_id'] = $target_user_id;
            $w2['status'] = array('in',[$this::STATUS_PAY, $this::STATUS_CONFIRM, $this::STATUS_COMPLAIN]);

            $total2 = $this->where($w2)
                ->count();
        }
        if($total1 > 0){
            return array('ret'=>1,'msg'=>'对方有未完成订单');
        }
        if($total2 > 0){
            return array('ret'=>1,'msg'=>'您有未完成的订单');
        }
        return array('ret'=>0);
    }
    //获取用户已完成的订单
    public function getFinishList($userId)
    {

        $tableName = "ds_orders";
        $status = $this::STATUS_FINISH;
        $sql = <<<SQL
SELECT * from {$tableName} WHERE (user_id = {$userId} AND status = {$status})
OR (target_user_id = {$userId}  AND status = {$status}) ORDER BY finish_time desc
SQL;
        $list = Db::query($sql);
        foreach ($list as &$value){
            if($value['user_id'] ==$userId){
                $value['types'] = 1;
            }elseif ($value['target_user_id'] ==$userId){
                $value['types'] = 2;
            }
        }
        return $list;
    }
}