<?php  
	
	/**
	 * 控制器
	 */
	Class CounselAction extends CommonAction{
        //添加处理
		public function index(){
            $ann = D('counsel')->order('type_id desc,sort desc')->select();

            $this->assign('ann',$ann);
			$this->display();
		}
        //添加处理
		public function add(){
		
			$this->display();
		}
        //添加处理
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
		//添加处理
		public function addHandle(){

			$_POST['logo_url'] =  $this -> upload();
			if (M('counsel')->data($_POST)->add()) {
				//添加日志操作
				$desc = '添加资讯';
				write_log(session('username'),'admin',$desc);

				$this->success('添加成功!',U(GROUP_NAME.'/Counsel/index'));
			}else{
				$this->error('添加失败！');
			}
		}

		//修改视图
		public function edit(){
            $ann = D('counsel')->where(array('id'=>I('id')))->find();
            $ann['content'] = stripslashes($ann['content']);
            $this->assign('ann',$ann);
			$this->display();
		}


		//修改处理
		public function editHandle(){
			$id = I('id');
			unset($_POST['id']);

            if(!empty($_FILES['image']['tmp_name'])){
                $_POST['logo_url'] = $this -> upload();
            }
			M('counsel')->where(array('id'=>$id))->data($_POST)->save();
			//添加日志操作
			$desc = '修改资讯';
			write_log(session('username'),'admin',$desc);

			$this->success('修改成功',U(GROUP_NAME.'/Counsel/index'));
		}

		//删除
		public function delete(){
			if (M('counsel')->where(array('id'=>I('id')))->delete()) {
				//添加日志操作
				$desc = '删除资讯';
				write_log(session('username'),'admin',$desc);
				$this->success('删除成功!');
			}else{
				$this->error('删除失败!');
			}
			
		}
}
?>