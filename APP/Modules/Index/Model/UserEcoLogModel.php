<?php

class UserEcoLogModel extends Model
{

    public function getType($type)
    {
        switch ($type) {
            case 1:
                return '签到收益';
            case 2:
                return '市场买入';
        }
    }


    public static function addInfo($userId, $remark, $magic, $old, $new, $type)
    {
        $entity = new self();

        $entity->user_id = $userId;
        $entity->remark = $remark;
        $entity->magic = $magic;
        $entity->old = $old;
        $entity->new = $new;
        $entity->create_time = time();
        $entity->types = $type;

        return $entity->save();
    }

    /**
     * @param User $user
     * @param $data
     * @param int $type 1:添加 -1:减少
     * @return bool
     */
    public function changeUserMagic($user_id, $data, $type = 1)
    {
        Db::startTrans();
        try {

            $user = new \app\common\entity\User();
            $userinfo = $user->getUserInfo($user_id);
            $old_magic = $userinfo['magic'];
            $magic = $data['magic'];
            if ($type == 1) {
                $new_magic = bcadd($old_magic, $data['magic'], 8);
            }

            if ($type == -1) {
                $new_magic = bcsub($old_magic, $data['magic'], 8);
                $magic = -1 * $data['magic'];
            }

            if ($user->save(['magic'=>$new_magic],['id'=>$user_id]) === false) {
                throw new \Exception('保存失败');
            }

            $result = self::addInfo($user_id, $data['remark'], $magic, $old_magic, $new_magic, $data['type']);

            if (!$result) {
                throw new \Exception('保存失败');
            }

            Db::commit();

            return true;
        } catch (\Exception $e) {

            Db::rollBack();

            return false;
        }
    }
    public function magiclogdata($type='',$userId = ''){
        $where = [];
        if($userId){
            $where[] = ['user_id','=',$userId];
        }
        if($type){
            $where[] = ['type','=',$type];
        }
        $list = self::where($where)->order("create_time desc")->select();
        foreach ($list as $key => &$value) {
            $value['types'] = self::getType($value['types']);
        }
        return $list;

    }
    //查询账单
    public function magicloglist($type = '', $userId = '', $page = 1, $limit = 20)
    {
        $offset = ($page - 1) * $limit;
        $query = self::where('user_id', $userId)->field('*');
        if ($type == 1) {
            $query->where("magic", "GT", 0);
        } else if($type == -1){
            $query->where("magic", "LT", 0);
        }

        $total = self::where('user_id', $userId)->count();

        $list = $query->order("create_time desc")->limit($offset, $limit)->select();

        foreach ($list as $key => &$value) {
            $value['types'] = self::getType($value['types']);
        }

        return array(
            'list' =>$list,
            'total' =>$total,
        );
    }
}