<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2020/4/29
 * Time: 16:30
 */
class BonusModel extends Model
{

    public function getLastRecord($where){

        return $this->where($where)->order('add_time desc')->find();
    }
    public function getRecord($where,$order='add_time desc'){

        return $this->where($where)->order($order)->select();
    }
    public function saveProductRecord($data){

        return $this->add($data);

    }

}