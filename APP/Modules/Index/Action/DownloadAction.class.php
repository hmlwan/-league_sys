<?php  
	//下载相关控制器
	Class DownloadAction extends Action{

		//联系我们
		public function index(){

            $REQUEST_URI = $_SERVER['REQUEST_URI'];
		    $key = parse_url($REQUEST_URI)['query'];
		    $info = M('download')->where(array('key'=>$key))->find();
            if(!$info){
                $this->display('Index:404');
                exit;
            }
            $score = set_number($info['score'],1);
            $score_arr = explode('.',$score);
            $this->assign('info',$info);
            $this->assign('score_arr',$score_arr);
			$this->display();
		}
	}
?>