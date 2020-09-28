<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2020/4/26
 * Time: 17:38
 */

class InviteRecordModel extends Model
{

    public function getByUserId($user_id){
        return $this->where(array('user_id'=>$user_id))->find();
    }

    public function editRecord($w,$data){

        $info = $this->where($w)->find();
        if($info){
            unset($data['add_time']);
            $r = $this->where($w)->save($data);
        }else{
            $r = $this->add($data);
        }
        if($r){
            return true;
        }
        return false;
    }
    public function addRecord($data){

        $r = $this->add($data);
        if($r){
            return true;
        }
        return false;
    }
}