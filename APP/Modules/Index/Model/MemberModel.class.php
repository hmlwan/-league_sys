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
    public function saveInfo($id,$data){
        return $this->where(array('id' => $id))->save($data);

    }
    /*获取父级 3代 4代 5代 6代*/
    public function getLeagueParents($pid,$arr=array(),$i=1){
        if($pid){
            $p_info = $this->getByUserId($pid);
            if($p_info){
                if($i <= 3){
                    $arr['level_3'][] =  $p_info['id'];
                }elseif ($i == 4){
                    $arr['level_4'][] =  $p_info['id'];
                }elseif ($i == 5){
                    $arr['level_5'][] =  $p_info['id'];
                }elseif ($i == 6){
                    $arr['level_6'][] =  $p_info['id'];
                }
                $i = $i + 1;
                if($i > 6){
                    return $arr;
                }
                if($p_info['parent_id'] > 0){
                    return $this->getLeagueParents($p_info['parent_id'],$arr,$i);
                }
            }
        }
        return $arr;
    }
}