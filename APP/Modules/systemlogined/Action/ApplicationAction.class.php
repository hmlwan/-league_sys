<?php  
	
	/**
	 * 应用控制器
	 */
	Class ApplicationAction extends CommonAction{

		//类别视图
		public function apptype(){
			$type = M('application_type')->order('sort desc')->select();
			$this->assign('type',$type);
			$this->display();
		}



		//添加类别视图
		public function addapptype(){
			$this->display();
		}

		//添加类别处理
		public function addAppTypeHandle(){

			if (M('application_type')
                ->data(array(
                    'name'=>I('name'),
                    'num'=>I('num'),
                    'sort'=>I('sort'),
                    'status'=>I('status'),
                    ))
                ->add()) {
				//添加日志操作
				$desc = '添加一个新的应用类别';
				write_log(session('username'),'admin',$desc);

				$this->success('添加成功!',U(GROUP_NAME.'/Application/apptype'));
			}else{
				$this->error('添加失败!');
			}
		}
		
		//修改公告类别视图
		public function editapptype(){
			$type = M('application_type')->where(array('id'=>I('id')))->find();
			$this->assign('type',$type);
			$this->display();
		}

		//修改公告类别处理
		public function editAppTypeHandle(){
			M('application_type')->where(array('id'=>I('id')))->save(array(
			    'name'=>I('name'),
                'num'=>I('num'),
                'sort'=>I('sort'),
                'status'=>I('status')));
			//添加日志操作
			$desc = '修改了一个应用类别';
			write_log(session('username'),'admin',$desc);

			$this->success('修改成功！',U(GROUP_NAME.'/Application/apptype'));
		}

		//删除公告类别
		public function deleteAppType(){
			//删除公告类别
			//先判断当前类别是否有公告
			if (M('application')->where(array('type_id'=>I('id')))->find()) {
				$this->error('对不起，该分类下面有应用！');
			}else{
				M('application_type')->where(array('id'=>I('id')))->delete();
				//添加日志操作
				$desc = '删除应用类别';
				write_log(session('username'),'admin',$desc);

				$this->success('删除成功！');
			}	
		}

		//公告列表视图
		public function app(){
            $ann = D('AppRelation')->relation(true)->order('sort desc')->select();

            $this->assign('ann',$ann);
			$this->display();
		}

		//添加公告视图
		public function addapp(){
		
			//获取公告类别
			$type = M('application_type')->order('sort desc')->select();
			$this->assign('type',$type);
			$this->display();
		}

		Public function upload(){
			import('ORG.Net.UploadFile');
			$upload = new UploadFile();// 实例化上传类
			$upload->maxSize  = 1000000 ;// 设置附件上传大小
			$upload->allowExts  = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
			$upload->savePath =  './Public/Uploads/app/'.date("Ymd",NOW_TIME)."/";// 设置附件上传目录
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
		//添加公告处理
		public function addAppHandle(){

			$_POST['logo_url'] =  $this -> upload();
			if (M('application')->data($_POST)->add()) {
				//添加日志操作
				$desc = '添加应用';
				write_log(session('username'),'admin',$desc);

				$this->success('添加成功!',U(GROUP_NAME.'/Application/app'));
			}else{
				$this->error('添加失败！');
			}
		}

		//修改公告视图
		public function editapp(){
            $type = M('application_type')->order('sort desc')->select();
            $this->assign('type',$type);
            $ann = D('AppRelation')->where(array('id'=>I('id')))->relation(true)->find();
            $this->assign('ann',$ann);
			$this->display();
		}


		//修改公告处理
		public function editAppHandle(){
			$id = I('id');
			unset($_POST['id']);

            if(!empty($_FILES['image']['tmp_name'])){
                $_POST['logo_url'] = $this -> upload();
            }
			M('application')->where(array('id'=>$id))->data($_POST)->save();
			//添加日志操作
			$desc = '修改应用';
			write_log(session('username'),'admin',$desc);

			$this->success('修改成功',U(GROUP_NAME.'/Application/app'));
		}

		//删除公告
		public function deleteApp(){
			if (M('application')->where(array('id'=>I('id')))->delete()) {
				//添加日志操作
				$desc = '删除应用';
				write_log(session('username'),'admin',$desc);
				$this->success('删除成功!');
			}else{
				$this->error('删除失败!');
			}
			
		}

    public function download(){
        $ann = D('download')->where(array('status'=>1))->order('id desc')->select();

        $this->assign('ann',$ann);
        $this->display();
    }

    public function adddown(){
        //获取公告类别
        $this->display();
    }
    public function addDownHandle(){

        $_POST['logo_url'] =  $this -> upload();
        if(M('download')->where(array('key'=>$_POST['key']))->find()){
            $this->error('该标识已存在！');
        }
        if (M('download')->data($_POST)->add()) {
            //添加日志操作
            $desc = '添加下载页';
            write_log(session('username'),'admin',$desc);

            $this->success('添加成功!',U(GROUP_NAME.'/Application/download'));
        }else{
            $this->error('添加失败！');
        }
    }

    public function editdown(){

        $ann = D('download')->where(array('id'=>I('id')))->find();
        $ann['content'] = stripslashes($ann['content']);
        $this->assign('ann',$ann);
        $this->display();
    }
    public function editDownHandle(){
        $id = I('id');
        unset($_POST['id']);

        if(!empty($_FILES['image']['tmp_name'])){
            $_POST['logo_url'] = $this -> upload();
        }
        M('download')->where(array('id'=>$id))->data($_POST)->save();
        //添加日志操作
        $desc = '修改下载页';
        write_log(session('username'),'admin',$desc);
        $this->success('修改成功',U(GROUP_NAME.'/Application/download'));
    }

    public function deleteDown(){
        if (M('download')->where(array('id'=>I('id')))->delete()) {
            //添加日志操作
            $desc = '删除下载页';
            write_log(session('username'),'admin',$desc);
            $this->success('删除成功!');
        }else{
            $this->error('删除失败!');
        }

    }
}
?>