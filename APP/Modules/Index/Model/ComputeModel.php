<?php


class ComputeModel extends Model
{
    /**
     * 退租
     */
    public function do_rehire($record){
//        $record_id = $request->post('record_id');
        $product_m = D("Product");
        if(!$record){
//            return json(['code'=>1,'message'=>'缺少参数']);
            return false;
        }
        $record_id = $record['id'];
        $user_id = $record['user_id'];
        $product_record_info = $product_m->getOneProductRecord($record_id);
        if(!$product_record_info){
//            return json(['code'=>1,'message'=>'不存在']);
            return false;
        }
        $period = $product_record_info['period'] * 24 * 3600;
        $left_day = ($period + $product_record_info['add_time'])-time();
        if($left_day > 0){
//            return json(['code'=>1,'message'=>'未到退租时间']);
            return false;
        }

        //更新租用记录
        $save_where['id'] =  $record_id;
        $save_data =  array(
            'is_run' =>  1,
        );
        $save_r = $product_m->saveProductRecord($save_where,$save_data);
//        return json(['code'=>0,'message'=>'退租成功','toUrl'=>'index/product/expired_machine']);
    }
}


