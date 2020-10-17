<?php

class UserEcoLogModel extends Model
{

    public function getType($type)
    {
        switch ($type) {
            case 1:
                return '实名奖励';
            case 2:
                return '签到奖励';
            case 3:
                return '联盟奖励';
            case 4:
                return '积分过期';
            case 5:
                return '订单奖励';
            case 6:
                return '订单返利';
        }
    }
    public  function addInfo($userId, $remark, $num, $old, $new, $type,$valid_period)
    {
        $add_data = array(
            'user_id' => $userId,
            'remark' => $remark,
            'num' => $num,
            'old' => $old,
            'new' => $new,
            'create_time' => time(),
            'types' => $type,
            'valid_period' => $valid_period,
        );
        return $this->add($add_data);
    }

    /**
     * @param User $user
     * @param $data
     * @param int $type 1:添加 -1:减少
     * @return bool
     */
    public function changeUserNum($user_id, $data, $type = 1)
    {
        $this->startTrans();
        try {

            $user = M('member');
            $userinfo = $user->where(array('id'=>$user_id))->find();
            $old_jifen = $userinfo['jifen'];
            $jifen = $data['num'];
            if ($type == 1) {
                $new_jifen = bcadd($old_jifen, $data['num'], 2);
            }
            if ($type == -1) {
                $new_jifen = bcsub($old_jifen, $data['num'], 2);
                $jifen = -1 * $data['num'];
            }
            if ($user->where(['id' => $user_id])->save(['jifen'=>$new_jifen]) === false) {
                throw new \Exception('保存失败');
            }
            $result = $this->addInfo($user_id, $data['remark'], $jifen, $old_jifen, $new_jifen, $data['type'], $data['valid_period']);

            if (!$result) {
                throw new \Exception('保存失败');
            }

            $this->commit();

            return true;
        } catch (\Exception $e) {

            $this->rollBack();

            return false;
        }
    }
    public function logdata($type='',$userId = ''){
        $where = [];
        if($userId){
            $where['user_id'] = $userId;
        }
        if($type){
            $where['types'] = $type;
        }
        $list = $this->where($where)->order("create_time desc")->select();
        foreach ($list as $key => &$value) {
            $value['types'] = $this->getType($value['types']);
        }
        return $list;

    }
    //查询账单
    public function loglist($type = '', $userId = '', $page = 1, $limit = 20)
    {
        $offset = ($page - 1) * $limit;
        $where = array(
            'user_id' => $userId
        );
        if ($type == 1) {
            $where['num'] = array('GT',0);

        } else if($type == -1){
            $where['num'] = array('LT',0);
        }
        $total = $this->where($where)->count();
        $list = $this->where($where)->order("create_time desc")->limit($offset, $limit)->select();

        foreach ($list as $key => &$value) {
            $value['types'] = $this->getType($value['types']);
        }

        return array(
            'list' =>$list,
            'total' =>$total,
        );
    }
}