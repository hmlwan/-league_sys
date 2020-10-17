<?php

/**
 * Created by PhpStorm.
 * Date: 2020/10/13
 * Time: 18:06
 */
class LeagueAction extends CommonAction
{

    public function _initialize()
    {
        $user_id = session('mid');
        $member_senior_info = M('member_senior_cert')->where(array('user_id'=>$user_id))->find();

        if($member_senior_info['is_senior_cert'] != 1){
            $this->redirect('/index/member/senior_cert');
        }
    }

    /*联盟任务*/
    public function index(){
        $user_id = session('mid');
        $m = D('LeagueConf');
        $map['status'] = 1;
        $list = $m->getConf($map);

        $mem_league_info = $m->getMemLeague(array('user_id'=>$user_id));
        $this->assign('mem_league_info',$mem_league_info);

        /*是否满足领取条件*/
        $data = array();
        foreach ($list as $k => $value){

            if($value['sort'] <= $mem_league_info['key']){
//                unset($list[$k]);
            }else{
                $is_reveive = 0;
                $key = $k + 2;
                if($key > 6){
                    $key = 6;
                }
                $team_buy_ask_arr = explode("|",$value['team_buy_ask']);
                $value['team_buy_ask_1'] = $team_buy_ask_arr[1];
                $value['team_buy_ask_2'] = $team_buy_ask_arr[0];
                if(($mem_league_info['push_level_one_num'] >= $value['push_level_one_num'])
                    &&($mem_league_info['team_num'] >= $value['team_num'])
                    && ($mem_league_info['push_level_one_ask'] >= $value['push_level_one_ask'])
                    && ($mem_league_info["team_buy_ask_{$key}"] >= $team_buy_ask_arr[0])
                    && ($mem_league_info['key'] + 1) == $value['sort']
                ){
                    $is_reveive = 1;
                }
                if($k > 0){
                    $value['push_level_one_name'] =  $list[$k-1]['name'];
                }
                $value['is_reveive'] = $is_reveive;
                $data[] = $value;
            }
        }
        $this->assign('list',$data);

        $this->display();
    }
    /*已经领取*/
    public function already_receive(){
        $m = D('LeagueConf');
        $user_id = session('mid');

        $map['user_id'] = $user_id;
        $list = $m->getRecord($map);

        foreach ($list as $k => $value){
            if($value['key'] == 1){
                unset($list[$k]);
            }
        }

        $this->assign('list',$list);
        $this->display();
    }
    /**
     * 升级
     */
    public function update_level(){
        $id = I('id');
        $m = D('LeagueConf');
        $member = D('Member');
        $user_id = session('mid');

        $member_league_m = M('member_league');
        $league_conf = $m->getInfoById($id);
        if(!$id || !$league_conf){
            $this->ajaxReturn(array('info' => '参数错误！', 'result' => -1));
        }
        $member_league = $member_league_m->where(array('user_id'=>$user_id))->find();
        if(!$member_league){
            $this->ajaxReturn(array('info' => '请先去高级认证！', 'result' => -1,'toUrl'=>U('/index/member/senior_cert')));
        }
        /*收取时间*/
        $league_start_receive = C('league_start_receive');
        $league_end_receive = C('league_end_receive');
        if(time()< strtotime($league_start_receive) || time() > strtotime($league_end_receive) ){
            $this->ajaxReturn(array('info' => "升级时间为{$league_start_receive}-{$league_end_receive}"));
        }

        $r = $member_league_m->where(array('user_id'=>$user_id))->save(array(
            'key' => $league_conf['sort'],
            'push_level_one_ask' => 0,
            'sxf_rate'=>$league_conf['trade_rate']
        ));

        if(!$r){
            $this->ajaxReturn(array('info' => '升级失败！', 'result' => -1));
        }
        //升级记录
        $update_r = M('member_league_receive')->add(array(
            'user_id' => $user_id,
            'mobile' => session('username'),
            'last_key' => $member_league['key'],
            'key' => $league_conf['sort'],
            'add_time' => time(),
            'reward_product_id' => $league_conf['reward_product_id'],
        ));

        if(!$update_r){
            $this->ajaxReturn(array('info' => '升级失败！', 'result' => -1));
        }
        //赠送矿机
        $product_m = D("Product");
        $product_info = $product_m->getInfoById($league_conf['reward_product_id']);
        if($product_info){
            $product_m->addProductRecord(array(
                'user_id' => $user_id,
                'product_id' => $league_conf['reward_product_id'],
                'period' => $product_info['period'],
                'is_run' => 0,
                'hold_num' => 1,
                'return_num' => $product_info['return_num'],
                'energy_num' => $product_info['energy_num'],
                'types' => 2,
            ));
        }
        //更新直推要求
        $mem_info = $member->getByUserId($user_id);
        if($mem_info['parent_id'] > 0){
            $p_w = array(
                'user_id' => $mem_info['parent_id']
            );
            $p_member_league = $member_league_m->where($p_w)->find();
            if($p_member_league){
                $all_league_conf = $m->getConf(array('status'=>1),'sort desc');
                $last_league_conf = $all_league_conf[0];
                if($last_league_conf['sort'] == $p_member_league['key']){
                    if( $league_conf['sort'] == $p_member_league['key']){
                        $member_league_m->where($p_w)->setInc('push_level_one_num',1);
                    }
                }else{
                    if( ($league_conf['sort'] + 1) == $p_member_league['key']){
                        $member_league_m->where($p_w)->setInc('push_level_one_num',1);
                    }
                }
            }
        }
        $this->ajaxReturn(array('info' => '升级成功！', 'result' => 1, 'toUrl' => U('/index/league/already_receive')));

    }
}