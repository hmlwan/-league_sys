<?php

/**
 * Created by PhpStorm.
 * Date: 2020/10/12
 * Time: 17:41
 */
class LeagueConfModel extends Model
{
    public function getInfoById($id)
    {
        return $this->where(['id' => $id])->find();
    }
    public function getInfoBySort($sort)
    {
        return $this->where(['sort' => $sort])->find();
    }
    public function getOne($where){
        return $this->where($where)->find();
    }
    public function getConf($where,$order='sort asc'){

        $list = $this->where($where)->order($order)->select();

        return $list;
    }

    public function getMemLeague($where){
        $info = M('member_league')->where($where)->find();

        if(!$info){
            return array();
        }
        $league_info = $this->getInfoBySort($info['key']);

        $info['name'] = $league_info['name'];
        $next_league_info = $this->getConf(array('sort'=>array('gt',$info['key'])));

        $next_team_buy_ask_desc = 6;
        if($next_league_info){
            $team_buy_ask = $next_league_info[0]['team_buy_ask'];
            $team_buy_ask_arr = explode("|",$team_buy_ask);
            $next_team_buy_ask_desc = $team_buy_ask_arr[1];
        }
        $info['next_team_buy_ask_desc'] = $next_team_buy_ask_desc;
        $info['next_team_buy_ask_num'] = $info["team_buy_ask_{$next_team_buy_ask_desc}"];
        return $info;
    }
    /**
     * @param $where
     * @param string $order
     * @return
     *  记录
     */
     public function getRecord($where,$order='add_time desc'){

        $list =  M('member_league_receive')->where($where)->order($order)->select();

        foreach ($list as $k=>&$value){
            $league_info = $this->getInfoBySort($value['key']);
            if(!$league_info){
                unset($list[$k]);
            }else{
                $team_buy_ask_arr = explode("|",$league_info['team_buy_ask']);
                $league_info['team_buy_ask_1'] = $team_buy_ask_arr[1];
                $league_info['team_buy_ask_2'] = $team_buy_ask_arr[0];
                if($value['key'] > 1){
                    $push_level_one_info = $this->getInfoBySort(($value['key']-1));
                    $league_info['push_level_one_name'] = $push_level_one_info['name'];
                }
                $value['league_info'] = $league_info;
            }
        }
        return $list;
    }
    public function saveRecord($where,$data){
        $r =  M('member_league_receive')->where($where)->save($data);
        return $r;
    }



    public function getOneProductRecord($id){
        return M('product_record')->where('id',$id)->find();
    }
    public function addProductRecord($data){
        $data['add_time'] = time();
        $r =  M('product_record')->add($data);
        return $r;
    }

}