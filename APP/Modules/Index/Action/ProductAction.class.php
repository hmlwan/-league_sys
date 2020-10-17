<?php

/**
 * Created by PhpStorm.
 * Date: 2020/9/23
 * Time: 9:47
 */
class ProductAction extends CommonAction
{
    public function _initialize()
    {
        $user_id = session('mid');
        $member_senior_info = M('member_senior_cert')->where(array('user_id'=>$user_id))->find();

        if($member_senior_info['is_senior_cert'] != 1){
            $this->redirect('index/member/senior_cert');
        }
    }

    /**
     * 租用空间
     */
    public function machine_hire(){

        $where['status'] = 1;
        $product_m = D("Product");
        $list = $product_m->getProductConf($where);
        $this->assign('list',$list);
        $this->display();
    }
    /**
     *  租用空间
     */
    public function do_hire(){
        $product_id = I('product_id');
        $product_m = D("Product");
        if(!$product_id){
            $this->ajaxReturn(array('info' => '确少参数！', 'result' => -1));
        }
        $map['id'] = $product_id;
        $product_info = $product_m->getOneProduct($map);
        if(!$product_info || $product_info['status'] != 1){
            $this->ajaxReturn(array('info' => '该空间已被禁止租用！', 'result' => -1));
        }
        $member = D('Member');
        $user_id = session('mid');
        $usre_info = $member->getByUserId($user_id);

        $num = set_number($product_info['num'],2);
        if($usre_info['is_cert'] != 1){
            $this->ajaxReturn(array('info' => '还未实名，请去实名！', 'result' => -1,'toUrl'=>U('/index/login/cert')));
        }
        if($usre_info['ane'] < $num){
            $this->ajaxReturn(array('info' => 'ANE数量不足！', 'result' => -1));
        }
        $running_machine_where['user_id'] = $user_id;
        $running_machine_where['product_id'] = $product_id;
        $running_machine_where['is_run'] = 0;
        $running_machine = $product_m->getProductRecord($running_machine_where);

        if(count($running_machine)>= $product_info['hold_num']){
            $this->ajaxReturn(array('info' => '已达到可持有数量！', 'result' => -1));
        }
        //收益记录
        $magic_log = D('UserAneLog')->changeUserNum($user_id,array(
            'num' => $num,
            'remark' => '租用空间消耗'.$num.'ANE',
            'type'=> 4,
        ),-1);
        if(!$magic_log){
            $this->ajaxReturn(array('info' => 'ANE数量不足！', 'result' => -1));
        }
        //租用记录
        $hire_data = array(
            'user_id' => $user_id,
            'product_id' => $product_id,
            'period' =>  $product_info['period'],
            'num' =>  $product_info['num'],
            'return_num' =>  $product_info['return_num'],
            'energy_num' =>  $product_info['energy_num'],
            'hold_num' =>  $product_info['hold_num'],
        );
        $hire_r = $product_m->addProductRecord($hire_data);
        if(false === $hire_r){
            $this->ajaxReturn(array('info' => '租用失败！', 'result' => -1));
        }
        //联盟推广
        $member_league_m = M('member_league');
        $league_parents = $member->getLeagueParents($usre_info['parent_id']);

        if($league_parents){
            //三代内上级
            if(!empty($league_parents['level_3'])){
                $member_league_m
                    ->where(array('user_id'=>array('in',$league_parents['level_3'])))
                    ->setInc('team_buy_ask_3',1);
            }
            //四代内上级
            if(!empty($league_parents['level_4'])){
                $data_4['team_buy_ask_3'] = array('exp','team_buy_ask_3+1');
                $data_4['team_buy_ask_4'] = array('exp','team_buy_ask_4+1');
                $member_league_m
                    ->where(array('user_id'=>array('in',$league_parents['level_4'])))
                    ->save($data_4);
            }
            //五代内上级
            if(!empty($league_parents['level_5'])){
                $data_5['team_buy_ask_3'] = array('exp','team_buy_ask_3+1');
                $data_5['team_buy_ask_4'] = array('exp','team_buy_ask_4+1');
                $data_5['team_buy_ask_5'] = array('exp','team_buy_ask_5+1');
                $member_league_m
                    ->where(array('user_id'=>array('in',$league_parents['level_3'])))
                    ->save($data_5);
            }
            //六代内上级
            if(!empty($league_parents['level_6'])){
                $data_6['team_buy_ask_3'] = array('exp','team_buy_ask_3+1');
                $data_6['team_buy_ask_4'] = array('exp','team_buy_ask_4+1');
                $data_6['team_buy_ask_5'] = array('exp','team_buy_ask_5+1');
                $data_6['team_buy_ask_6'] = array('exp','team_buy_ask_6+1');
                $member_league_m
                    ->where(array('user_id'=>array('in',$league_parents['level_3'])))
                    ->save($data_6);
            }
        }
        $this->ajaxReturn(array('info' => '租用成功！', 'result' => 1, 'toUrl' => U('/index/product/running_machine')));
    }
    /*运行中*/
    public function running_machine(){

        $user_id = session('mid');
        $where['user_id'] = $user_id;
        $where['is_run'] = 0;
        $product_m = D("Product");
        $compute_m = D("Compute");

        $list = $product_m->getProductRecord($where);
        if($list){
            foreach ($list as $k=>&$value){
                $period = $value['period'] * 24 * 3600;
                $left_day = ($period + $value['add_time']) - time() ;

                if ($left_day > 0) {
                    $value['is_rehire'] = 2;
                    if($left_day > 24*3600){
                        $value['left_day'] = intval($left_day / (24 * 3600)).'天';
                    }elseif ($left_day>3600){
                        $value['left_day'] = intval($left_day / 3600).'小时';
                    }elseif ($left_day>60){
                        $value['left_day'] = intval($left_day / 60).'分钟';
                    }else{
                        $value['left_day'] = '1分钟';
                    }
                } else {//可退租
//                    $value['is_rehire'] = 1;
                    $compute_m->do_rehire($value);
                    unset($list[$k]);
                }
            }
        }
        $this->assign('list',$list);
        $this->display();

    }
    /*领取收益*/
    public function receive_earnings(){
        $user_id = session('mid');
        $where['user_id'] = $user_id;
        $where['is_run'] = 0;
        $product_m = D("Product");
        $list = $product_m->getProductRecord($where);
        $receive_m = M('product_receive_record');

        $is_receive = $receive_m->where(array(
            'user_id' => $user_id,
            'receive_time' => array('between',array(
                strtotime(date("Y-m-d 0:0:0",time())),
                strtotime(date("Y-m-d 23:59:59",time())))
            ),
        ))->find();

        if($is_receive){
            $this->ajaxReturn(array('info' => '今日已领取！', 'result' => -1));
        }
        $total_num = 0;
        foreach ($list as $value){
            $receive_num = $value['hold_num'] * $value['energy_num'];
            $total_num += $receive_num;
            M('product_record')->where(array('id'=>$value['id']))->save(array(
                'last_receive_time' =>  $value['receive_time'],
                'receive_time' =>  time(),
                'actual_num' =>  $receive_num,
                'receive_times' =>  $value['receive_times'] + 1,
                'total_receive_num' =>  $value['total_receive_num'] + $receive_num,
            ));
        }
        $total_num = set_number($total_num,2);
        /*记录*/
        $receive_r = $receive_m->add(array(
            'user_id' => $user_id,
            'mobile' => session('username'),
            'receive_time' => time(),
            'total_num' => $total_num,
        ));
        if(false === $receive_r){
            $this->ajaxReturn(array('info' => '领取失败！', 'result' => -1));
        }
        /*明细*/
        D('UserAneLog')->changeUserNum($user_id,array(
            'num' => $total_num,
            'remark' => '挖矿奖励'.$total_num.'ANE',
            'type'=> 1,
        ));
        /*用户数据*/
        D('UserStatistics')->setFieldInc($user_id,'total_product_receive',$total_num);
        $this->ajaxReturn(array('info' => "领取成功,获得{$total_num} ANE", 'result' => 1));
    }

    /*已到期*/
    public function expired_machine(){
        $user_id = session('mid');
        $where['user_id'] = $user_id;
        $where['is_run'] = 1;
        $product_m = D("Product");
        $list = $product_m->getProductRecord($where,'add_time desc');
        $this->assign('list',$list);
        $this->display();
    }

    public function newcomer_intro(){
        $this->display();
    }




}