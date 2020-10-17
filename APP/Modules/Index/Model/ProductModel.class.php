<?php

/**
 * Created by PhpStorm.
 * Date: 2020/10/12
 * Time: 17:41
 */
class ProductModel extends Model
{
    public function getInfoById($id)
    {
        return $this->where(['id' => $id])->find();
    }

    public function getOneProduct($where){
        return $this->where($where)->find();
    }
    public function getProductConf($where,$order='sort asc'){

        $list = $this->where($where)->order($order)->select();
        foreach ($list as &$value){
            $value['show_logo_img'] = rawurldecode(urlencode(urldecode($value['logo_url'])));
        }
        return $list;
    }
    public function getType($type){
        switch ($type){
            case 1:
                return '购买奖励';
            case 2:
                return '团队奖励';
            case 3:
                return '高级认证奖励';
        }
    }

    /**
     * @param $where
     * @param string $order
     * @return
     *  租用记录
     */
    public function getProductRecord($where,$order='add_time desc'){

        $list =  M('product_record')->where($where)->order($order)->select();
        foreach ($list as $k=>&$value){
            $map['id'] = $value['product_id'];
            $product_info = $this->getOneProduct($map);
            if(!$product_info){
                unset($list[$k]);
            }else{
                $value['product_name'] = $product_info['product_name'];
                $value['logo_url'] = $product_info['logo_url'];
                $value['bg_color'] = $product_info['bg_color'];
                $value['type_name'] = $this->getType($product_info['types   ']);
            }
        }
        return $list;
    }
    public function getOneProductRecord($id){
        return M('product_record')->where('id',$id)->find();
    }
    public function addProductRecord($data){
        $data['add_time'] = time();
        $r =  M('product_record')->add($data);
        return $r;
    }
    public function saveProductRecord($where,$data){
        $data['receive_time'] = time();
        $r =  M('product_record')->where($where)->save($data);
        return $r;
    }
}