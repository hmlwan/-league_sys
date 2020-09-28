<?php
class MemberRebateOrderModel extends Model
{

    public function getScencName($scene){
        switch ($scene){
            case 1:
                return '淘宝';
            case 2:
                return '京东';
            case 3:
                return '拼多多';
            case 4:
                return '苏宁';
            case 5:
                return '唯品会';
        }

    }

    public function getInfo($w){
        return $this->where($w)->find();
    }
    public function addInfo($data){
        return $this->add($data);

    }

    public function getAllOrder($w){

        return $this->where($w)->select();

    }
    public function saveInfo($w,$data){
        return $this->where($w)->save($data);
    }

}