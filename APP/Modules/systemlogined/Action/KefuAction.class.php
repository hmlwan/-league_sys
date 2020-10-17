<?php
class KefuAction extends CommonAction {

    public function index(){
        $m = M('member_senior_cert'); // 实例化Data数据对象
        import("@.ORG.Util.Page");// 导入分页类
        $mobile = $_POST['mobile'];
        $map = array();
        if (!empty($mobile)) {
            $map['m.username'] = $mobile;
        }
        $count      = $m->alias('c')->where($map)->count();// 查询满足要求的总记录数
        $Page       = new Page($count,25);// 实例化分页类 传入总记录数

        $list = $m->alias('c')
            ->join('LEFT JOIN ds_member as m  ON c.user_id=m.id')
            ->where($map)
            ->order("is_senior_cert,2,3,1")
            ->field('c.*,m.truename,m.idcard,m.username')
            ->limit($Page ->firstRow.','.$Page -> listRows)
            ->select();
        $show       = $Page->show();// 分页显示输出
        $this->assign('page',$show);// 赋值分页输出
        $this->assign('list',$list);// 赋值数据集
        $this->display(); // 输出模板

    }
    public function cert(){
        $id = I('get.id');
        $this->assign('id',$id);
        $this->display();
    }
    public function cert_op(){
        $id = I('id');
        $is_senior_cert = I('is_senior_cert');

        $cert_fail_reason = I('cert_fail_reason','');
        if(!$id){
            $this -> error('未知错误');
        }
        $m = M('member_senior_cert');
        if($is_senior_cert == 3 && !$cert_fail_reason){
            $this -> error('请填写驳回原因');
        }
        $r = $m->where(array('id'=>$id))->save(array(
            'is_senior_cert' => $is_senior_cert,
            'cert_fail_reason' => $cert_fail_reason,
            'update_time' => time(),
        ));
        if(!$r){
            $this -> error('操作失败');
        }
        //认证成功赠送矿机
        if($is_senior_cert == 1){
            $league_conf = M('league_conf')->where(array('sort'=>1))->find();

            if($league_conf){
                $mem_id =  $m->where(array('id'=>$id))->getField('user_id');
                $mem_info = M('member')->where(array('id'=>$mem_id))->find();

                if($mem_info){
                    $product_info = M('product')->find($league_conf['reward_product_id']);
                    if($product_info){
                        $r = M("product_record")->add(array(
                            'user_id' => $mem_id,
                            'product_id' => $league_conf['reward_product_id'],
                            'period' => $product_info['period'],
                            'num' => $product_info['num'],
                            'return_num' => $product_info['return_num'],
                            'energy_num' => $product_info['energy_num'],
                            'types' => 3,
                            'is_run' => 0,
                            'hold_num' => 1,
                            'add_time' => time(),
                        ));
                        if($r){
                            /*联盟奖励*/
                            M('member_league')->add(array(
                                'user_id' => $mem_id,
                                'key' => 1,
                                'sxf_rate'=> $league_conf['trade_rate']
                            ));
                            M('member_league_receive')->add(array(
                                   'user_id' => $mem_id,
                                   'mobile' => $mem_info['username'],
                                   'key' => 1,
                                   'reward_product_id' => $league_conf['reward_product_id'],
                                   'add_time' => time(),
                               )
                            );
                            /*上级+1*/
                            if($mem_info['parent_id'] > 0 && $mem_info['is_cert'] == 1){
                                $mem_info1 = M('member')->where(array('id' => $mem_info['parent_id']))->find();
                                $member_senior_cert1 = M('member_senior_cert')
                                    ->where(array('user_id'=>$mem_info['parent_id']))
                                    ->getField('is_senior_cert');
                                if($mem_info1 && $member_senior_cert1 == 1){ //高级认证
                                    $mem_league_info1 = M('member_league')
                                        ->where(array('user_id'=>$mem_info['parent_id']))
                                        ->find();

                                    $member_league1_data = array(
                                        'push_level_one_num' => $mem_league_info1['push_level_one_num']+1,//直推人数
                                        'team_num' => $mem_league_info1['team_num']+1, //团队人数
                                    );
                                    //上级是体验大使
                                    if($mem_league_info1['key'] == 1){
                                        $member_league1_data['push_level_one_ask'] = $mem_league_info1['push_level_one_ask']+1;
                                    }
                                    M('member_league')
                                        ->where(array('user_id'=>$mem_info['parent_id']))
                                        ->save($member_league1_data);

                                    if($mem_info1['parent_id'] > 0 ){
                                        $mem_info2 = M('member')->where(array('id' => $mem_info1['parent_id']))->find();
                                        $member_senior_cert2 = M('member_senior_cert')
                                            ->where(array('user_id' => $mem_info1['parent_id']))
                                            ->getField('is_senior_cert');
                                        if($mem_info2 && $member_senior_cert2 == 1) { //高级认证
                                            $mem_league_info2 = M('member_league')
                                                ->where(array('user_id' => $mem_info1['parent_id']))
                                                ->find();

                                            M('member_league')
                                                ->where(array('user_id' => $mem_info1['parent_id']))
                                                ->save(array(
                                                    'team_num' => $mem_league_info2['team_num'] + 1,
                                                ));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        $this->success('操作成功',U(GROUP_NAME .'/Kefu/index'));
    }

}
