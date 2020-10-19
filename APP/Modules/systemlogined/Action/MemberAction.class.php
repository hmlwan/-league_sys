<?php  

	/**
	* 会员管理控制器
	*/
	class MemberAction extends CommonAction{

		//会员列表
		public function check(){
			
			$map = $this -> _search();
			$pid=I('get.pid',0,'intval');
			if(!empty($pid)){
				$map['parent_id'] = array('eq',$pid);	
			}
			$type=$_POST['type'];
			$typename=$_POST['typename'];
			
	        if (!empty($type) && !empty($typename)) {
				if($type ==1){
					$map['username']=	$typename;
				}elseif($type ==2){
					$map['truename']=$typename;	
				}

	        }			
			if (method_exists($this, '_search_filter')) {
				$this -> _search_filter($map);
			}
			$name = $this -> getActionName();
			
			
			$model = D($name);
			if (!empty($model)) {
				$this -> _list($model, $map);
			}
			$this->display();
		}
		
		
		
			//已封
		public function lockuser(){
			
			$map = $this -> _search();
			$map['lock'] = array('eq',1);
			$type=$_POST['type'];
			$typename=$_POST['typename'];
			
	        if (!empty($type) && !empty($typename)) {
				if($type ==1){
					$map['username']=	$typename;
				}elseif($type ==2){
					$map['truename']=$typename;	
				}
	        }			
			if (method_exists($this, '_search_filter')) {
				$this -> _search_filter($map);
			}
			$name = $this -> getActionName();
			
			$model = D($name);
			if (!empty($model)) {
				$this -> _list($model, $map);
			}

			$this->display();
		}



		public function gaward(){

            $league_conf = M('league_conf')->where("status=1")->order('sort asc')->select();
            $this->assign('league',$league_conf);
            $this->display();
			
	    }
		public function gawardpost(){
			
            $level = I('post.level');
            $num = I('post.num');

            if(empty($level)){
                $this->error('请选择联盟等级');
            }
            if(empty($num)){
                $this->error('请输入AME数量');
            }
            $league_bonus_m = M('league_bonus');
            $league_bonus = $league_bonus_m
                ->where(array(
                    'level' => $level,
                    'add_time' => array('between',array(
                        strtotime(date("Y-m-d 0:0:0",time())),
                        strtotime(date("Y-m-d 23:59:59",time())))
                    ),
                ))->find();
            if($league_bonus){
                $this->error('该等级今日已分红');
            }

            $member_league_m = M('member_league');
            $member_league = $member_league_m->alias('l')
                ->join(" LEFT JOIN ds_member as m ON l.user_id=m.id")
                ->where(array('l.key'=>$level))
                ->field('l.*,m.username as mobile')
                ->select();
            if(empty($member_league)){
                $this->error('该等级暂时没有用户会员');
            }
            $member_league_count = count($member_league);
            $bonus_id = $league_bonus_m->add(array(
                'level' => $level,
                'num' => $num,
                'add_time' => time(),
                'member_num' => $member_league_count,
            ));
            if(!$bonus_id){
                $this->error('分红失败');
            }
            $league_bonus_detail_m = M('league_bonus_detail');

            foreach ($member_league as $value){

                $league_bonus_detail_m->add(array(
                    'bonus_id' => $bonus_id,
                    'user_id' => $value['user_id'],
                    'mobile' => $value['mobile'],
                    'level' => $level,
                    'num' => $num,
                    'add_time' => time(),
                ));
                /*明细*/
                D("UserAneLog")->changeUserNum($value['user_id'],array(
                    'num' => $num,
                    'remark' => '联盟分红'.$num.'联盟积分',
                    'type'=> 6,
                ));
            }
            $this->success("分红成功！",U(GROUP_NAME.'/Member/awardlist'));

	    }

		//封号解封处理
		public function editFeng(){
			$lock = I('get.lock',0,'intval');
			$id = I('get.id',0,'intval');
			M('member')->where(array('id'=>$id))->save(array("lock"=>$lock));
            $this->success('设置成功！',U(GROUP_NAME.'/Member/check'));

		}
		/**
		 * 金币充值
		 * @return [type] [description]
		 */
		public function addJinbi(){
			$member = M('member')->where(array('id'=>I('get.id',0,'intval')))->find();
			
			$map['desc'] = '平台充值';
			$map['member'] = $member['username'];
			$list = M("jinbidetail")->where($map)->order("id desc")->select();
			$this->assign('list',$list);	
            $this->assign('member',$member);			
			$this->display();
		}

		/**
		 * 金币充值处理函数
		 * @return [type] [description]
		 */
		public function addJinbiHandle(){
			$userid = I('post.id',0,'intval');
			 $jinbi  = I('post.money',0,'intval');
			
			$member = M('member')->where(array('id'=>$userid))->find();
			if($jinbi>0){
		        M('member')->where(array('id'=>$userid))->setInc('money',$jinbi);
				//写入充值记录
				$data            = array();
				$data['member']  = $member['username'];
				$data['adds']     = $jinbi;
				$data['balance'] = $member['money'] + $jinbi;
				$data['addtime'] = time();
				$data['desc']    = '平台充值';
				M('jinbidetail')->add($data);
				$this->success('充值成功！',U(GROUP_NAME.'/Member/check'));
			}elseif($jinbi<0){
				$oldjinbi =$member['money'];
				$jinbi =abs($jinbi);
                 M('member')->where(array('id'=>$userid))->setDec('money',$jinbi);
				$data = array();
				$data['member']  = $member['username'];
				$data['reduce']  = $jinbi;
				$data['balance'] = (floatval($oldjinbi) - floatval($jinbi));
				$data['addtime'] = time();
				$data['desc']    = '平台充值';
				M('jinbidetail')->add($data);		
                $this->success('扣除成功！',U(GROUP_NAME.'/Member/check'));				
				
			}
			
		}

		//编辑会员
		public function editMember(){
			$member = M('member')->where(array('id'=>I('id')))->find();
			$this->assign('member',$member);
			$this->display();
		}

		//编辑会员处理函数
		public function editMemberHandle(){
			$password = I('password');
			$truename = I('truename');
			
			$id = I('id');
			unset($_POST['id']);
			if ($password!= '') {
				$_POST['password'] = md5($password);
			}else{
				unset($_POST['password']);
			}

			if ($truename != '') {
				$_POST['truename'] = $truename;
			}else{
				unset($_POST['truename']);
			}
			if (M('member')->where(array('id'=>$id))->save($_POST)) {
				$this->success('编辑成功！',U(GROUP_NAME.'/Member/check'));
			}else{
				$this->error('数据没有更改！',U(GROUP_NAME.'/Member/check'));
			}
		}

		/**
		 * 后台直接跳转到会员前台
		 * @return [type] [description]
		 */
		public function inMember(){
			$username = I('get.u');
			$uid = M('member')->where(array('username'=>$username))->getField('id');
			session('mid',$uid);
			session('username',$username);
			session('usersecondlogin','1');
			session('member','adminlogin');
			$this->redirect('Index/Wallet/index');
		}

		//删除会员
		public function deleteMember(){
			$member = M('member');
			$minfo = $member->where(array('id'=>I('get.id',0,'intval')))->find();
			if ($member->where(array('id'=>$_GET['id']))->delete()) {
				alert('删除成功！',U(GROUP_NAME.'/Member/check'));
			}else{
				alert('删除失败！',U(GROUP_NAME.'/Member/check'));
			}			
		}
		
	    //树形图
		public function shu_list(){
			Vendor('Tree.tree');
			$menu = new tree;
				$menu->icon = array('│ ','├─ ','└─ ');
				$menu->nbsp = '&nbsp;&nbsp;&nbsp;';
				$result = M('member')->field('id,username,parentcount,parent')->select();
				foreach($result as $k=>$v){
					 
					 $arr[$v['username']] = $v;
					 $arr[$v['username']]['parentid_node'] = ($v['parent'])? ' class="child-of-node-'.$v['parent'].'"' : '';
				}
				$str  = "<tr id='node-\$username' \$parentid_node>
							<td style='padding-left:30px;'>\$spacer 会员编号：\$username (直推人数：\$parentcount)</td>
						</tr>";
			     
				$menu->init($arr);
				$categorys = $menu->get_tree(NULL, $str);		
                $this->assign('categorys',$categorys);					
			    $this->display();
		}

		public function awardlist(){

			$Data = M('league_bonus'); // 实例化Data数据对象
			import("@.ORG.Util.Page");// 导入分页类
			$map = array();
			if (isset($_GET['level']) && $_GET['level']!='') {
				$map['level'] = $_GET['level'];
			}

			$count      = $Data->where($map)->count();// 查询满足要求的总记录数
			$Page       = new Page($count,30);// 实例化分页类 传入总记录数

			$list = $Data->where($map)->order('add_time desc')->limit($Page ->firstRow.','.$Page -> listRows)->select();
			foreach($list as $k => $v){
			    $level_name = M('league_conf')->where(array('sort'=>$v['level']))->getField('name');
				$list[$k]['level_name'] = $level_name ? $level_name : "";
			}
			$show       = $Page->show();// 分页显示输出
			$this->assign('page',$show);// 赋值分页输出
			$this->assign('list',$list);// 赋值数据集
			$this->display(); // 输出模板

		}
        public function awarddetail(){

            $bonus_id = I('get.bonus_id');
            if(!$bonus_id){
                $this->redirect(U(GROUP_NAME.'/Member/awardlist'));

            }
            $Data = M('league_bonus_detail'); // 实例化Data数据对象
            import("@.ORG.Util.Page");// 导入分页类
            $map = array(
                'bonus_id' => $bonus_id
            );
            if (isset($_POST['mobile']) && $_POST['mobile']!='') {
                $map['mobile'] = array("eq",$_POST['mobile']);
            }

            $count      = $Data->where($map)->count();// 查询满足要求的总记录数
            $Page       = new Page($count,30);// 实例化分页类 传入总记录数


            $list = $Data->where($map)->order('add_time desc')->limit($Page ->firstRow.','.$Page -> listRows)->select();
            if($list){
                foreach($list as $k => $v){
                    $level_name = M('league_conf')->where(array('sort'=>$v['level']))->getField('name');
                    $list[$k]['level_name'] = $level_name ? $level_name : "";
                }
            }

            $show       = $Page->show();// 分页显示输出
            $this->assign('page',$show);// 赋值分页输出
            $this->assign('list',$list);// 赋值数据集
            $this->display(); // 输出模板

        }
        public function shuadan(){

            $this->display();

        }
        public function addshuadan(){
            $number = $_POST['number'];
            $member = M('member')->where("robotcount > 0")->setInc('logincount',$number);
            if($member){
                alert('执行成功！',U(GROUP_NAME.'/Member/shuadan'));
            }
        }

        /*求购订单*/
        public function order(){

            $order_m = D('Orders'); // 实例化Data数据对象
            import("@.ORG.Util.Page");// 导入分页类
            $status = I('status');
            $mobile = I('mobile');
            $w = array();
            $w['o.types'] = $order_m::TYPE_BUY;
            if ($status) {
                $w['status'] = $status;
            }
            if ($mobile) {
                $w['username'] = $mobile;
            }

            $count      = $order_m->alias('o')->where($w)->count();// 查询满足要求的总记录数

            $Page       = new Page($count,30);// 实例化分页类 传入总记录数
            $list = $order_m->alias('o')
                ->field('o.*,u.truename,u.username as mobile')
                ->where($w)
                ->limit($Page ->firstRow.','.$Page -> listRows)
                ->join(" LEFT JOIN ds_member u ON u.id = o.user_id")
                ->order("o.status,6,1,2,3,4,5")
                ->select();
            foreach ($list as &$value){
                $value['status_name'] =  $order_m->getStatus($value['status']);
            }
            $show       = $Page->show();// 分页显示输出
            $this->assign('page',$show);// 赋值分页输出
            $this->assign('list',$list);// 赋值数据集
            $this->display(); // 输出模板
        }
        /*求购订单*/
        public function order_detail(){

            $id = I('get.order_id');
            $order_m = D('Orders');
            $order = $order_m->getOneById($id);
            if (!$order) {
                $this->redirect('order');

            }
            $order['status_name'] = $order_m->getStatus($order['status']);
            $userInfo = M('member')->where('id='.$order['user_id'])->find();
            if ($order['status'] > 1) {
                $targetUser = M('member')->where('id='.$order['target_user_id'])->find();
            }
            $this->assign([
                'order' => $order,
                'userInfo' => $userInfo,
                'targetUser' => isset($targetUser) ? $targetUser : ''
            ]);
            $this->display();
        }

        public function deleteOrder()
        {
            $order_m = D('Orders');
            $id = I('get.order_id');

            $order = $order_m->getOneById($id);
            if (!$id || !$order) {
               $this->error('订单不存在');
            }

            $save_data = array('id'=>$order['id']);
            if ($order['status'] == 1) {
                $r = $order_m->saveOrder(
                    $save_data,
                    array('status'=>5,'expired_time'=>time())
                );
            } else if ($order['status'] == 2 || $order['status'] == 6) {
                $order_m->saveOrder($save_data,array('status'=>5,'expired_time'=>time()));
                $re_num = $order['number'] + $order['charge_number'];
                $uml_m = D("UserAneLog");

                $r = $uml_m->changeUserNum($order['target_user_id'], [
                    'num' => $re_num,
                    'remark' => '市场卖出退回'.$re_num.'ANE',
                    'type' => 9
                ], 1);
            }

            if (!$r) {
                $this->error('取消失败');
            }
            $this->success('取消成功');

        }

        /**
         * @power 交易市场|出售订单@确认收款
         */
        public function updateOrder()
        {
            $id = I('get.order_id');
            $order_m = D('Orders');
            $order = $order_m->getOneById($id);
            if (!$id || !$order) {
                $this->error('订单不存在');
            }
            if ($order['status'] < $order_m::STATUS_CONFIRM){
                $this->error('订单还没付款，不能操作');
            }
            $result = true;
            if ($order['status'] == 3 ||$order['status'] == 6 ) {
                //是否首次交易成功
//                $trade_succuss_w = array(
//                    'user_id' => $order['user_id'],
//                    'status' => 4,
//                );
//                $trade_succuss_info = Orders::get($trade_succuss_w);

                $result = $order_m->saveOrder(array('id' => $order['id']),
                    array(
                        'status' => 4,
                        'finish_time' => time())
                );
                $number = $order['number'];
                $uml_m = D("UserAneLog");

                $r = $uml_m->changeUserNum($order['user_id'], [
                    'num' => $number,
                    'remark' => '市场买入' . $number . 'ANE',
                    'type' => 7
                ], 1);
            }
            if(!$result){
                $this->error('操作失败');

            }
            $this->success('操作成功');
        }
    }

?>