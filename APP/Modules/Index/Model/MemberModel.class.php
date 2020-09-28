<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2020/4/26
 * Time: 17:38
 */

class MemberModel extends Model
{
    public function getByUserId($id){

        return $this->where(array('id'=>$id))->find();

    }
    public function getByUserMobile($mobile){
        return $this->where(array('username'=>$mobile))->find();

    }

}