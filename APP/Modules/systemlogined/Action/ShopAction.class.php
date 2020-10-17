<?php  

	/**
	* 会员管理控制器
	*/
	class ShopAction extends CommonAction{
		
		//列表
		public function lists(){
			$product = M("product");
			$map['title'] = array("LIKE","%{$_GET['title']}%");
		    import("@.ORG.Util.Page");
			$count = $product -> where($map)->count();
			$Page       = new Page($count,10);
			$show = $Page -> show();
			$products = $product -> where($map) -> limit($Page ->firstRow.','.$Page -> listRows)->order('sort asc') -> select();
            $this -> assign("page",$show);
			$this -> assign("products",$products);
			$this -> display(); 			
		}
		public function banner(){
			$user = M("banner");
			$banner = $user ->order('id asc') -> select();
			$this -> assign("banner",$banner);
			$this -> display(); 			
		}
		//添加商城广告
		public function addshopbanner(){

			$banner = M('shopbanner');
			$data['id']=$_POST['id'];
			$data['sort']=$_POST['sort'];
			$_POST['path'] = $this -> upload();
				if($banner ->create()){
					if($banner -> add()){
					    $this->success('添加成功',U(GROUP_NAME .'/Shop/shopbanner'));
					}else{
						$this -> error('添加失败');
					}
				}			

		}
	public function delshopbanner(){
		$id = I('id');
		$banner = M("shopbanner");
		$map['id'] = array('in',$id);
		if($banner -> where($map) -> delete($id)){
				$this->success('删除商品成功',U(GROUP_NAME .'/Shop/shopbanner'));
		}else{
			$this -> error("删除失败");
		}
	}
		//商城滚动图
		public function shopbanner(){
			$user = M("shopbanner");
			$shopbanner = $user ->order('id asc') -> select();
			$this -> assign("shopbanner",$shopbanner);
			$this -> display(); 			
				
		}
        public function product(){
            $this->display();
        }
		

		public function add_product(){
			$this->display();
		}
		//添加广告
		public function addbanner(){

			$banner = M('banner');
			$data['href']=$_POST['href'];
			$_POST['path'] = $this -> upload();
			if($banner ->create()){
				if($banner -> add()){
					$this->success('添加成功',U(GROUP_NAME .'/Shop/banner'));
				}else{
					$this -> error('添加失败');
				}
			}

		}
		//添加商品表单处理
		public function addProductHandle(){
			$product = M('product');

			$_POST['logo_url'] = $this -> upload();
            if($product ->create()){
                if($product -> add()){
                    $this->success('添加成功',U(GROUP_NAME .'/Shop/lists'));
                }else{
                    $this -> error('添加失败');
                }
            }
		}
		
			//修改商品
		public function edit_product(){
			$product = M("product");
	        $id = $_GET['id'];
			$data = $product -> find($id);		
			$this -> assign('product',$data);			
			$this->display();
		}
		
			//修改guanggao 
		public function editbanner(){
			$banner = M('banner');
	        $id = $_GET['id'];
			$banners = $banner -> find($id);				
			$this->assign('banners',$banners);			
			$this->display();
		}
		
			//修改商品表单处理
		public function editProductHandle(){
			
			$product = M("product");
			$id = I('id',0,'intval');
			unset($_POST['id']);
			$data['id']=$_POST['tid'];
            if(!empty($_FILES['logo_url']['tmp_name'])){
                   $_POST['logo_url'] = $this -> upload();
            }			
			$product->where(array('id'=>$id))->save($_POST);
			$this->success('修改成功!',U(GROUP_NAME .'/Shop/lists'));			
		
		}		
		
	public function delbanner(){
		$id = I('id');
		$banner = M("banner");
		$map['id'] = array('in',$id);
		if($banner -> where($map) -> delete($id)){
				$this->success('删除成功',U(GROUP_NAME .'/Shop/banner'));
		}else{
			$this -> error("删除失败");
		}
	}
		
	/**
	*	del() 删除商品
	*
	*/
	public function delProduct(){
		$id = I('id');
		$product = M("product");
		$map['id'] = array('in',$id);
		if($product -> where($map) -> delete($id)){
				//添加日志操作
				$desc = '删除一个商品';
			    write_log(session('username'),'admin',$desc);
				$this->success('删除商品成功',U(GROUP_NAME .'/Shop/lists'));
		}else{
			$this -> error("删除失败");
		}
	}
	
	//商品分类列表
	public function type_list(){
			$type = M('type');
			$types = $type -> field("*,concat(path,'-',id) tpath") -> order("ID ASC") ->select();
		     foreach($types as &$t){
				if($t['pid'] == 0){
					$data1 = $type -> field("path,pid") -> where("pid = '{$t['id']}'&& path = '0-{$t['id']}'") -> select(); 
					if(!$data1){
						$t['son'] = "0";
					}
				}else{
					  $video = M('video');
					  $data2 = $video -> field("tid")-> where("tid = {$t['id']}") -> select();
					  if(!$data2){
						 $t['video'] = "0";
					  }
				}
			 }

              $this -> assign("types",$types);
			  $this -> display();
		}

		//添加商品分类
		public function add_type(){
			
			$this->display();
		}
		
		//商品分类表单处理
		public function addTypeHandle(){
			$type = M('type');
		

					if($type -> add($_POST)){
						//添加日志操作
						$desc = '添加一个新的商品分类';
						write_log(session('username'),'admin',$desc);
					   $this->success('添加成功',U(GROUP_NAME .'/Shop/type_list'));
					}else{
						
						$this -> error('添加失败');
					}		
		}
		//添加子模块
		public function addSon(){
			$this -> display();
		}
		//添加子模块表单处理
		public function addSonHandle(){
			$type = M('type');
			$pid = $_POST['pid'];
			$_POST['path'] = "0-{$pid}"; 
				 
			if($type -> create()){
					if($type -> add()){
					  //添加日志操作
						$desc = '添加一个商品分类子类';
						write_log(session('username'),'admin',$desc);
					   $this->success('添加成功',U(GROUP_NAME .'/Shop/type_list'));
					}else{
						
						$this -> error('添加失败');
					}
			}
		}		
		
		//删除类型
		public function delType(){
			$id = I('id');
			$type = M('type');
			$map['id'] = array('in',$id);
			if($type -> where($map) -> delete($id)){
				//添加日志操作
				$desc = '删除一个商品分类';
			    write_log(session('username'),'admin',$desc);
				$this->success('删除分类成功',U(GROUP_NAME .'/Shop/type_list'));
			}else{
				$this -> error('删除失败');
			}

		}		
        //修改分类
      	public function	editType(){
			$type = M('type')->where(array('id'=>I('id')))->find();
			$this->assign('type',$type);			
			$this->display();
		}
		//修改分类处理
		public function editTypeHandle(){
			$id = I('id',0,'intval');
			unset($_POST['id']);
			M('type')->where(array('id'=>$id))->save($_POST);
			//添加日志
			$desc = '修改ID为'. $id .'商品分类';
			write_log(session('username'),'admin',$desc);

			$this->success('商品分类修改成功!',U(GROUP_NAME .'/Shop/type_list'));

		}		
		
		//异步验证分类是否存在
		public function checkTypeName(){
			//判断是否异步提交
			IS_AJAX or halt('对不起，页面不存在');

			if (M('type')->where(array('name'=>I('name')))->getField('id')) {
				echo 'false';
			}else{
				echo 'true';
			}
		}	

      Public function upload(){
		  import('ORG.Net.UploadFile');
		  $upload = new UploadFile();// 实例化上传类
		  $upload->maxSize  = 1000000 ;// 设置附件上传大小
		  $upload->allowExts  = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
		  $upload->savePath =  './Public/Uploads/'.date("Ymd",NOW_TIME)."/";// 设置附件上传目录
		 if(!$upload->upload()) {// 上传错误提示错误信息
		     $this->error($upload->getErrorMsg());
		 }else{// 上传成功 获取上传文件信息
		      $info =  $upload->getUploadFileInfo();
		 }
			if($info){
				$savepath = str_replace(".","",$info[0]['savepath']);
				$filePath = $savepath.$info[0]['savename'];

				return $filePath;
			}else{
				$this -> error($upload -> getError());
			}
      }	

      public function orderlist(){
		  
          $m = M("product_record");
          $product_m = M("product");
          import("@.ORG.Util.Page");
          $mobile = I('get.mobile');
          $w = array();
          if($mobile){
             $w['m.username'] = $mobile;
          }
			$count = $m->alias('p')
                ->where($w)
                ->count();
			$Page       = new Page($count,20);
			$show = $Page -> show();
			$orders = $m->alias('p')
                ->where($w)
                ->join("LEFT JOIN ds_member as m ON p.user_id=m.id")
                ->field('p.*,m.username as mobile')
                -> limit($Page ->firstRow.','.$Page -> listRows)
                ->order('id desc')
                -> select();
			if($orders){
                foreach ($orders as &$value){
                    $product_name = $product_m->where(array('id'=>$value['product_id']))->getField('product_name');
                    $value["product_name"] = $product_name ?$product_name :'';
                }
            }

            $this -> assign("page",$show);
			$this -> assign("list",$orders);
			$this -> display(); 		  

	  }

        public function order_record(){

            $m = M("product_receive_record");

            import("@.ORG.Util.Page");
            $mobile = I('get.mobile');
            $w = array();
            if($mobile){
                $w['mobile'] = $mobile;
            }
            $count = $m
                ->where($w)
                ->count();
            $Page       = new Page($count,20);
            $show = $Page -> show();
            $orders = $m
                ->where($w)
                -> limit($Page ->firstRow.','.$Page -> listRows)
                ->order('id desc')
                -> select();
            $this -> assign("page",$show);
            $this -> assign("list",$orders);
            $this -> display();

        }
        public function editshouyi(){
            $product=M('product')->select();
            $this->assign('product',$product);
            $this->display();

        }
        public function addshouyi(){
            $number['shouyi'] = $_POST['num'];
            $sid = $_POST['id'];
            if(empty($sid)){
                $this -> error('果树编号不能为空');
            }
            if(empty($number['shouyi'])){
                $this -> error('收益不能为空');
            }
            $order = M('order')->where(array('sid'=>$sid))->save($number);
            if($order){
                alert('执行成功！',U(GROUP_NAME.'/shop/orderlist'));
            }else{
                alert('执行失败！',U(GROUP_NAME.'/shop/editshouyi'));
            }
        }
		//删除订单
		public function delOrder(){
			$id = I('id');
			$order = M('order');
			$map['id'] = array('in',$id);
			if($order -> where($map) -> delete($id)){
				//添加日志操作
				$desc = '删除订单';
			    write_log(session('username'),'admin',$desc);
				$this->success('删除订单成功',U(GROUP_NAME .'/Shop/orderlist'));
			}else{
				$this -> error('删除失败');
			}

		}
       //订单详情
       public function 	editOrder(){
			$order = M('order')->where(array('id'=>I('id')))->find();
			$this->assign('order',$order);			
			$this->display();		   
	   }
	   
      //订单发货操作
	  
       public function editOrderHandle(){
		   
			$id = I('id',0,'intval');
			unset($_POST['id']);
			if($_POST['status']==2){
				
				$jinbidetail = M('jinbidetail');
				//订单信息
				$orderinfo = M('order')->where(array('id'=>$id))->find();
				//下单用户信息
				//$buyUser = M('member')->where(array('username'=>$orderinfo['member']))->find();
				/**
				//报单中心返点奖
				$money = C('BONUS_TJJ') * $orderinfo['money'];
				$oldjinbi = M('member')->where(array('username'=>$orderinfo['baodan']))->getField('jinbi');
				$data = array();
				$data['member']  = $orderinfo['baodan'];
				$data['adds']  = $money;
				$data['balance'] = (floatval($oldjinbi) + floatval($money));
				$data['addtime'] = time();
				$data['desc']    = $orderinfo['member'].'的商品:('.$orderinfo['stitle'].'),数量'.$orderinfo['num'].'件-报单返点奖。';
				$jinbidetail->add($data);
				//扣除推荐人余额
				M('member')->where(array('username'=>$orderinfo['baodan']))->setInc('jinbi',$money);
				**/
			    //订单状态更新	
				M('order')->where(array('id'=>$id))->save($_POST);
				/**
				//检测升级
				if($buyUser['groupid']==0){
					//如果是普通会员 检测升为1钻
					
					$arr['member'] = $buyUser['username'];
					$arr['groupid'] = 1;
					$arr['updatetime'] = NOW_TIME;
                    M('member')->where(array('id'=>$buyUser['id']))->save(array('groupid'=>1));//更新会员组	
                    M('updategroup')->add($arr);//写入升级记录									
				}
				//检测上级所有安置人是否符合并升级
				$ffid = fl_top_fid($buyUser['fparent'],1);
				$ffid = explode(",",$ffid);
				foreach($ffid as $k=>$v){
						$userinfo = M('member')->field('groupid,left,right')->where(array('username'=>$v))->find();
						//1-3级用户升级
						if($userinfo['groupid']>0 && $userinfo['groupid']<4){
							//获取下层消费数量		
							$left_count = get_product($userinfo['left']);	//左侧业绩	
							$right_count = get_product($userinfo['right']);	//右侧业绩
							$groupid = $userinfo['groupid'] + 1;//下个级别ID
							$member_group = M('member_group')->where(array('groupid'=>$groupid))->find();
							if(($left_count>=$member_group['cnum']) && ($right_count>=$member_group['cnum'])){
								//更新升级信息
								$arr['member'] = $v;
					            $arr['groupid'] = $groupid;
					            $arr['updatetime'] = NOW_TIME;
                                M('updategroup')->add($arr);//写入升级记录										
		                        M('member')->where(array('id'=>$v))->save(array('groupid'=>$groupid));									 		
							}
					  }
				}					
				**/
				//添加日志
				$desc = 'ID为'. $id .'订单发货';
				write_log(session('username'),'admin',$desc);
			

			}
			$this->success('订单操作成功!',U(GROUP_NAME .'/Shop/orderlist'));		   
		   
	   }

        //联盟奖励配置列表
        public function league(){
            $league_cfg_m = M("league_conf");
            $product_m = M('product');

            $map['name'] = array("LIKE","%{$_GET['name']}%");
            import("@.ORG.Util.Page");
            $count = $league_cfg_m -> where($map)->count();
            $Page       = new Page($count,10);
            $show = $Page -> show();
            $products = $league_cfg_m -> where($map) -> limit($Page ->firstRow.','.$Page -> listRows)->order('sort asc') -> select();
            foreach ($products as &$value){
                if($value['reward_product_id'] > 0){
                    $value['reward_product_name'] = $product_m->where(array('id'=>$value['reward_product_id']))->getField('product_name');
                }
                if($value['team_buy_ask']){
                    $team_buy_ask = explode("|",$value['team_buy_ask']);
                    $value['team_buy_ask_desc'] = $team_buy_ask[0]."次 （{$team_buy_ask[1]}代）";
                }
                if($value['push_level_one_ask']){
                    $sort = $value['sort'] - 1;
                    $push_level_one_ask_desc = $league_cfg_m->where(array('sort' => $sort))->getField('name');
                    $value['push_level_one_ask_desc'] = $push_level_one_ask_desc;
                }


            }
            $this -> assign("page",$show);
            $this -> assign("products",$products);
            $this -> display();
        }
        public function edit_league(){
            $league_cfg_m = M("league_conf");
            $product_m = M('product');

            if(IS_POST){
                $id = I("post.id");
                $data = I('post.');
                if($id){
                    $r = $league_cfg_m->where(array('id'=>$id))->save($data);
                }else{
                   unset( $data['id']);
                    $r = $league_cfg_m->add($data);
                }
                if(false === $r){
                    $this -> error('操作失败');
                }
                $this->success('操作成功',U(GROUP_NAME .'/Shop/league'));
            } else{
                $id = I("get.id");
                $data = $league_cfg_m -> find($id);
                $this -> assign('info',$data);

                $product = $product_m->where(array('status'=>1))->order('sort asc')->select();
                $this -> assign('product',$product);
                $this->display();
            }
        }

        public function del_league(){
            $id = I('id');
            if(!$id){
                $this -> error("删除失败");
            }
            $league_cfg_m = M("league_conf");
            $map['id'] = $id;
            if($league_cfg_m -> where($map) -> delete($id)){
                $this->success('删除成功',U(GROUP_NAME .'/Shop/league'));
            }else{
                $this -> error("删除失败");
            }
        }
        //升级记录
        public function league_record(){

            $mobile = I('get.mobile');
            $order = M("member_league_receive");
            $product_m = M('product');
            $league_conf_m = M('league_conf');
            import("@.ORG.Util.Page");
            $w = array();
            if($mobile){
                $w['mobile'] = $mobile;
            }
            $count = $order->where($w) ->count();
            $Page       = new Page($count,20);
            $show = $Page -> show();
            $list = $order->where($w)  -> limit($Page ->firstRow.','.$Page -> listRows)->order('add_time desc') -> select();
            foreach ($list as &$value){
                if($value['last_key']){
                    $value['last_level_name'] = $league_conf_m->where(array('sort'=>$value['last_key']))->getField('name');
                }
                $value['cur_level_name'] = $league_conf_m->where(array('sort'=>$value['key']))->getField('name');
                $value['product_name'] = $product_m->where(array('id'=>$value['reward_product_id']))->getField('product_name');
            }

            $this -> assign("page",$show);

            $this -> assign("list",$list);
            $this -> display();

        }

	}

?>