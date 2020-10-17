<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2020/4/26
 * Time: 17:38
 */

class UserStatisticsModel extends Model
{

    public function getByUserId($user_id){
        return $this->where(array('user_id'=>$user_id))->find();

    }

    public function setFieldInc($user_id,$field,$num){

        if(!$user_id){
            return false;
        }
        if($this->getByUserId($user_id)){
            $w = array('user_id'=>$user_id);
            $r = $this->where($w)->setInc($field,$num);
            if($field == 'one_sub_cert_nums' ){
                $r = $this->where($w)->setDec('one_sub_nocert_nums',$num);
            }
            if( $field == 'two_sub_cert_nums'){
                $r = $this->where($w)->setDec('two_sub_nocert_nums',$num);
            }
            if($field == 'one_sub_nocert_nums' || $field == 'two_sub_nocert_nums'){
                $this->where($w)->setInc("total_sub_nums",$num);
            }
        }else{
            $r = $this->add(array(
                'user_id' =>  $user_id,
                'one_sub_cert_nums' => $field == 'one_sub_cert_nums' ? $num : 0,
                'one_sub_nocert_nums' => $field == 'one_sub_nocert_nums' ? $num : 0,
                'two_sub_cert_nums' => $field == 'two_sub_cert_nums' ? $num : 0,
                'two_sub_nocert_nums' => $field == 'two_sub_nocert_nums' ? $num : 0,
                'total_product_receive' => $field == 'total_product_receive' ? $num : 0,
                'total_sub_nums' =>  $field != 'total_product_receive' ? $num : 0 ,
            ));
        }
        if(false !== $r){
            return true;
        }
        return false;
    }
}