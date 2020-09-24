<?php

/**
 * Created by PhpStorm.
 * Date: 2020/9/23
 * Time: 9:47
 */
class AppAction extends CommonAction
{

    public function index(){

        $list = M('application_type')->where(array('status'=>1))->order('sort desc')->select();
        if($list){
            foreach ($list as $k => $value){
                $app = M('application')
                    ->where(array('status'=>1,'type_id'=>$value['id']))
                    ->limit($value['num'])
                    ->order('sort desc')
                    ->select();
                if($app){
                    $list[$k]['app_list'] = $app;

                }else{
                    unset($list[$k]);
                }
            }
        }
        $this->assign('list',$list);
        $this->display();

    }
    public function get_more(){
        $type_id= I('type_id');
        $list = M('application')
            ->where(array(
                'type_id' => $type_id,
                'status'=>1)
            )
            ->order('sort desc')
            ->select();
        $type_name = M('application_type')->where(array('id'=>$type_id))->getField('name');
        $this->assign('list',$list);
        $this->assign('type_name',$type_name);
        $this->display();
    }
}