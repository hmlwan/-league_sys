<?php  
	/**
	 * 会员前台公共控制器
	 */
	Class CommonAction extends Action{

		public function _initialize(){

			header("Content-Type:text/html; charset=utf-8");
            import('ORG.Util.Page');
				
			//判断是否关闭了网站
			$open_web=C('open_web');
			if(empty($open_web)){
				$this->open_web_notice=C('open_web_notice');
				$this->display('Index:404');
					exit;
			}


	  		if(!isset($_SESSION['mid']) && !isset($_SESSION['username']) ){
	  			$this->redirect('Index/Login/index');
	  		}else{
				  $memberinfo = M("member")->where(array('username'=>$_SESSION['username']))->find();
				  $this->memberinfo = $memberinfo;
				  M("member")->where(array('id'=>$_SESSION['mid']))->save(array('online_time'=>time()));
				  
			}

            if ($_SESSION['username'] == 'admin') {
                $this->redirect('Index/Login/index');
            }
		}
		/*订单自动返利*/
        public function auto_rebate_order(){

            $MemberRebateOrder = D('MemberRebateOrder');
            //失效时间
            $rebate_invalid_days = getConf('rebate_invalid_days');
            //积分有效期
            $rebate_valid_days = getConf('rebate_valid_days');
            $rebate_all = $MemberRebateOrder->getAllOrder(array(
                'status' => array('in',array(0,1,2)),
                'is_receive' => 0
            ));
            $RebateOnlineOrder = D('RebateOnlineOrder');
            $rebate_invalid_second = $rebate_invalid_days * 24*3600;
            if($rebate_all){
                foreach ($rebate_all as $rebate){
                    $x = time() - $rebate['add_time'];
                     if( $x > $rebate_invalid_second){ //失效
                         $MemberRebateOrder
                             ->where(array('id'=>$rebate['id']))
                             ->save(array('status'=>3));
                     }else{
                        //更新内容
                         $online_info =  $RebateOnlineOrder->get_info($rebate['scene'],$rebate['order_no']);
                         if($online_info){
                             $add_data['img'] = $online_info['img'];
                             $add_data['title'] = $online_info['title'];
                             $add_data['order_time'] = $online_info['order_time'];
                             $add_data['commission'] = $online_info['commission'];
                             $add_data['price'] = $online_info['price'];
                             $add_data['status'] = $online_info['status'];
                             $add_data['num'] = $online_info['num'];

                             $MemberRebateOrder->saveInfo(array('id'=>$rebate['id']),$add_data);
                             if($add_data['status'] == 2){ //已结算
                                 //订单返利 明细
                                 D('UserEcoLog')->changeUserNum($rebate['user_id'],array(
                                     'num' => $rebate['num'],
                                     'remark' => '订单返利'.$rebate['num'].'生态积分',
                                     'type'=> 5,
                                     'valid_period' => $rebate_valid_days
                                 ));
                                 $MemberRebateOrder->saveInfo(
                                     array('id'=>$rebate['id']),
                                     array('is_receive'=>1,'receive_time'=>time()));
                             }
                         }

                     }
                }
            }
        }

        /*积分自动失效*/
        public function auto_jifen_invalid(){
            $UserEcoLog = D('UserEcoLog');
            $jifen_data = $UserEcoLog
                ->where(array(
                    'types'=> array('in',array(2,3,5)),
                    'valid_period' => array('neq',9999) //永久
                   )
                )
                ->select();
            if($jifen_data){
                foreach ($jifen_data as $jifen){
                    if( $jifen['valid_period'] != 0 &&
                        (time() - $jifen['create_time'])>($jifen['valid_period']*3600*24)){ //非永久。到时间自动过期
                        //积分过期 明细
                        D('UserEcoLog')->changeUserNum($jifen['user_id'],array(
                            'num' => $jifen['num'],
                            'remark' => '积分过期'.$jifen['num'].'生态积分',
                            'type'=> 4,
                            'valid_period' => 9999
                        ),-1);
                    }
                }
            }
        }

}


?>