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
              if($memberinfo['is_cert'] != 1){
                  $this->redirect('index/Login/cert');
              }
              $is_senior_cert = M('member_senior_cert')
                  ->where(array('user_id' => $memberinfo['id']))
                  ->getField('is_senior_cert');
              $this->assign('is_senior_cert',$is_senior_cert);
        }
        if ($_SESSION['username'] == 'admin') {
            $this->redirect('Index/Login/index');
        }
    }

    /*上传*/
    public function ajax_upload(){
        if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST"){

            $name = $_FILES['image']['name'];
            $size = $_FILES['image']['size'];

            $dir_name = I('dir_name','');
            $file_time = date('Ymd',time());
            $file_name = './Public/Uploads';
            if($dir_name){
                $file_name = $file_name.'/'.$dir_name;
            }
            if(!file_exists($file_name)){
                mkdir($file_name);
            }
            $path = $file_name.'/';

            $extArr = array("jpg", "png", "bmp", "jpeg");
            if(empty($name)){
                echo json_encode(array('result' => 0,'msg'=>'请选择要上传的图片'));
                return;

            }
            $ext = $this->extend($name);
            if(!in_array($ext,$extArr)){
                echo json_encode(array('result' => 0,'msg'=>'图片格式错误'));
                return;

            }
            if($size>(300*1024*1024)){
                echo json_encode(array('result' => 0,'msg'=>'图片大小不能超过3M'));
                return;

            }
            $image_name = time().rand(100,999).".".$ext;
            $tmp = $_FILES['image']['tmp_name'];

            $uploadip = substr($path,9);
            $savepath = ltrim($path.$image_name,'.');
            if(move_uploaded_file($tmp, $path.$image_name)){
                echo json_encode(array('result' => 1,'url'=>$savepath));
                return;
            }else{
                echo json_encode(array('result' => 0,'msg'=>'上传出错了'));
                return;
            }
            exit;
        }
        exit;
    }
    public function extend($file_name){
        $extend = pathinfo($file_name);
        $extend = strtolower($extend["extension"]);
        return $extend;
    }
}


?>