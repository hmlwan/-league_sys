<?php
//消息相关控制器
//QQ85917441
//2019-11-13
Class RobotAction extends CommonAction
{


  public function index()
  {
    $user_id = session('mid');
    $count = M('order')->where(array('user_id' => $user_id, 'zt' => 1))->count();
    $minfo = M('member')->where(array('id' => $user_id))->find();
    $this->assign('minfo', $minfo);
    $this->assign('count', $count);
    $this->display();
  }

  //商品详情
  public function pcontent()
  {

    $product = M("product");

    $typeData = $product->where("is_on = 0")->order("id asc")->select();
    foreach ($typeData as $kk => &$vv) {
      $vv['yuji'] = $vv['yxzq'] * $vv['shouyi'];
      $vv['sell'] = M("order")->where(array("sid" => $vv['id'], "user_id" => session('mid')))->count();
      $vv['shengyu'] = $vv['xiangou'] - $vv['sell'];
    }
    $this->assign("typeData", $typeData);
    $mai_log = M('order')->field('user,addtime')->order('id desc')->select();
    $this->assign('mai_log', $mai_log);
    $this->display();
  }

  //订单提交
  public function buy()
  {

    $id = I('get.id', 0, 'intval');
    $product = M("product");

    //查询村民信息
    $data = $product->find($id);
    if (empty($data)) {
      alert('果树不存在', U('Robot/index'));
    }

    $letter = M('type')->where(array('id' => $data['tid']))->getField('name');
    //判断 是否已经达到限购数量
    $my_gounum = M("order")->where(array("user" => session('username'), "sid" => $id))->count();
    if ($my_gounum >= $data['xiangou']) {
      echo '<script>alert("已经到达该树木种植上限！");window.history.back(-1);</script>';
      die;
    }
    if ($data['stock'] < 1) {
      echo '<script>alert("果树已经种植完毕，请改日再来！");window.history.back(-1);</script>';
      die;
    }
    $faquan = C('faquan');

    $username = session('username');
    $tuijian = M('member')->where(array('username' => $username))->getField('parent');
    if ($id == $faquan) {
      $jifen = M('member')->where(array('username' => $username))->getField('jifen');
      if ($jifen < $data['price']) {
        alert('账户金币不足,快去赚取金币吧！', U('task/index'));
      }

      M("member")->where(array('username' => session('username')))->setDec('jifen', $data['price']);
      $map = array();
      $map['kjbh'] = $letter . date('d') . substr(time(), -5) . sprintf('%02d', rand(0, 99));
      $map['user'] = $username;
      $map['user_id'] = session('mid');
      $map['project'] = $data['title'];
      $map['sid'] = $data['id'];
      $map['yxzq'] = $data['yxzq'];
      $map['shouyi'] = $data['shouyi'];
      $map['sumprice'] = $data['price'];
      $map['addtime'] = date('Y-m-d H:i:s');
      $map['imagepath'] = $data['thumb'];
      $map['zt'] = 1;
      $map['UG_getTime'] = time();
      if (M('order')->add($map)) {
        M('member')->where(array('username' => $username))->setInc('robotcount');
      }
    } else {

      $jinbi = getMemberField('money');
      if ($jinbi < $data['price']) {
        alert('账户余额不足,请先进行充值！', U('wallet/onlinerecharge'));
      }

      M("member")->where(array('username' => session('username')))->setDec('money', $data['price']);
      account_log(session('username'), $data['price'], '购买' . $data['title'], 0);
      $map = array();
      $map['kjbh'] = $letter . date('d') . substr(time(), -5) . sprintf('%02d', rand(0, 99));
      $map['user'] = $username;
      $map['tuijian'] = $tuijian;
      $map['user_id'] = session('mid');
      $map['project'] = $data['title'];
      $map['sid'] = $data['id'];
      $map['yxzq'] = $data['yxzq'];
      $map['shouyi'] = $data['shouyi'];
      $map['sumprice'] = $data['price'];
      $map['addtime'] = date('Y-m-d H:i:s');
      $map['imagepath'] = $data['thumb'];
      $map['zt'] = 1;
      $map['UG_getTime'] = time();
      if (M('order')->add($map)) {
        M('member')->where(array('username' => $username))->setInc('robotcount');
        // $one = $data['price'] * (C('ONE') / 100);
        // $two = $data['price'] * (C('TWO') / 100);
        // $three = $data['price'] * (C('THREE') / 100);
        // $ones = $data['price'] * (C('ONES') / 100);
        // $twos = $data['price'] * (C('TWOS') / 100);
        // $threes = $data['price'] * (C('THREES') / 100);
          $one = C('ONE');
        $two = C('TWO');
        $three = C('THREE');
        $ones = C('ONES');
        $twos = C('TWOS');
        $threes = C('THREES');
        $parent = getMemberField('parent');
        $parent1 = M('member')->where(array('username' => $parent))->getField('parent');
        $parent2 = M('member')->where(array('username' => $parent1))->getField('parent');

        $parentcount = M('order')->where(array('user' => $parent))->count();
        $parentcount1 = M('order')->where(array('user' => $parent1))->count();
        $parentcount2 = M('order')->where(array('user' => $parent2))->count();

        if ($parentcount > 0) {

          M("member")->where(array('username' => $parent))->setInc('money', $one);
          account_log($parent, $one, '1代生态奖励', 1, 2, 1, 0, $username);

        } else {
          M("member")->where(array('username' => $parent))->setInc('money', $ones);
          account_log($parent, $ones, '1代生态奖励', 1, 2, 1, 0, $username);
        }

        if ($parentcount1 > 0) {
          M("member")->where(array('username' => $parent1))->setInc('money', $two);
          account_log($parent1, $two, '2代生态奖励', 1, 2, 1, 0, $username);

        } else {
          M("member")->where(array('username' => $parent1))->setInc('money', $twos);
          account_log($parent1, $twos, '2代生态奖励', 1, 2, 1, 0, $username);
        }
        if ($parentcount2 > 0) {
          M("member")->where(array('username' => $parent2))->setInc('money', $three);
          account_log($parent2, $three, '3代生态奖励', 1, 2, 1, 0, $username);

        } else {
          M("member")->where(array('username' => $parent2))->setInc('money', $threes);
          account_log($parent2, $threes, '3代生态奖励', 1, 2, 1, 0, $username);
        }
      }
      $user_id = session('mid');
      $p_id = M('member')->where("id = {$user_id}")->getField('parent_id');
      $daishu = 3;

      if (!empty($p_id)) {
        for ($i = 1; $i <= $daishu; $i++) {
          $p_userinfo = M('member')->where("id = {$p_id}")->find();
          if (!empty($p_userinfo)) {
            if ($p_userinfo['level'] == 1) {//判断是否是城主
              $buyjj = $data['price'] * (C('buyjj') / 100);
              M('member')->where("id = {$p_id}")->setInc("money", $buyjj);

              account_log($p_userinfo['username'], $buyjj, $i . '代生态大使额外生态奖励-ID8' . $user_id, 1, 2);
            }
            $p_id = $p_userinfo['parent_id'];
            if (empty($p_id)) {
              break;
            }
          } else {

            break;
          }
        }
      }

    }
    $product->where(array("id" => $id))->setDec("stock");
    alert('树木周期认购完成！', U('Robot/robot'));
  }

  public function rank()
  {
    $list = M('member')->order('robotcount desc')->limit(3)->select();

    $lists = M('member')->order('robotcount desc')->limit(3, 27)->select();
    $this->assign('list', $list);
    $this->assign('lists', $lists);
    $this->display();
  }

  public function robot()
  {

    $zt = I('get.zt', 1, 'intval');
    $user_id = session('mid');
    $order = M("order");
    import("ORG.Util.Page");
    $count = $order->where("user_id = {$user_id} and zt = {$zt}")->count();
    $count1 = $order->where(array('user_id' => $user_id, 'zt' => $zt))->count();
    $total_list = $order->where(array('user_id' => $user_id, 'zt' => $zt))->select();
    $hour = 0;
    foreach ($total_list as $a => &$b) {
      $hour = $hour + $b['shouyi'];
    }
    $this->assign('hour', $hour);
    $Page = new Page($count, 8);
    $Page->setConfig('theme', '%first% %upPage% %linkPage% %downPage% %end%');
    $show = $Page->show();
    $jiesuan_time = C('jiesuan_time');
    if (empty($jiesuan_time)) {
      $jiesuan_time = 24;
    }
    $orders = $order->where("user_id = {$user_id} and zt = {$zt}")->limit($Page->firstRow . ',' . $Page->listRows)->order('id desc')->select();
    foreach ($orders as $k => &$v) {
      $sinfo = M('product')->where(['id' => $v['sid']])->find();
      $v['yuji'] = $sinfo['yxzq'] * $sinfo['shouyi'];
      $v['buy_price'] = $sinfo['price'];
      $a_time = (time() - strtotime($v['addtime'])) / 3600;

      $orders[$k]['a_time'] = round($a_time, 2);
      $timetmp = strtotime($v['addtime']) + $sinfo['yxzq'] * 60 * 60;
      $tmp = date("Y-m-d H:i:s", $timetmp);
      // $ntmp = $this->getRemainderTime(time(), $tmp);
      $orders[$k]['expire'] = $tmp;
      if (time() - $v['UG_getTime'] > $jiesuanTime * 3600) {
        $orders[$k]['isActive'] = 1;
      } else {
        $orders[$k]['isActive'] = 0;
      }
      $orders[$k]['getTime'] = $this->getHours(time() - $v['UG_getTime']);
      $orders[$k]['jiesuantime'] = $jiesuanTime;
      if (time() - $v['UG_getTime'] < $jiesuan_time * 3600) {
        $orders[$k]['is_jiesuan'] = 0;
      } else {
        $orders[$k]['is_jiesuan'] = 1;//可以结算
      }
    }
    $sum = $order->where(array('user_id' => $user_id))->sum('already_profit');
    $rwsm = C('rwsm');

    $mrkd = C('mrkd');
    $time = time();
    $mai_log = M('order')->field('user,addtime')->order('id desc')->select();
    $this->assign('mai_log', $mai_log);
    $this->assign("jiesuan_time", $jiesuan_time);
    $this->assign("count1", $count1);
    $this->assign("sum", $sum);
    $this->assign('time', $time);
    $this->assign('mrkd', $mrkd);
    $this->assign('rwsm', $rwsm);
    $this->assign("page", $show);
    $this->assign("zt", $zt);
    $this->assign("orders", $orders);
    $this->display();


  }

  function getHours($start_time, $end_time)
  {
    if (strtotime($start_time) > strtotime($end_time)) list($start_time, $end_time) = array($end_time, $start_time);
    $sec = $start_time - $end_time;
    $sec = round($sec / 60);
    $min = str_pad($sec % 60, 2, 0, STR_PAD_LEFT);
    $hours_min = floor($sec / 60);
    $min != 0 && $hours_min .= '.' . $min;
    return $hours_min;
  }


  public function jiesuan()
  {

    $id = I('get.id', 0, 'intval');

    $user_id = session('mid');
    $username = session('username');
    if (empty($id)) {
      alert('参数丢失！', U('Robot/robot'));
    }

    $order = M('order')->where("id = {$id} and zt = 1 and user_id = {$user_id}")->find();

    if (empty($order)) {
      $this->ajaxReturn(array('result' => 0, 'info' => '该村民不存在！'));
    }
    //判断与上次结算时间有没有达到24小时
    $jiesuan_time = C('jiesuan_time');
    if (empty($jiesuan_time)) {
      $jiesuan_time = 24;
    }
    if (time() - $order['UG_getTime'] < $jiesuan_time * 3600) {
      alert('领取收益间隔不到' . $jiesuan_time . '小时！', U('Robot/robot'));
    }
    //算出已经结算的时间
    $a_time = $order['UG_getTime'] - strtotime($order['addtime']);
    //本次将要结算的时间
    $n_time = time() - $order['UG_getTime'];
    $time = 0;//参加计算的时间；
    $data = array();
    $data['UG_getTime'] = time();
    $is_over = 1;
    if ($a_time + $n_time > $order['yxzq'] * 3600) {
      $time = ($order['yxzq'] * 3600) - $a_time;
      $data['zt'] = 2;
      $is_over = 0;
    } else {
      $time = $n_time;
    }

    $shouyi = $time / 3600 * $order['shouyi'];//本次收益

    M('order')->where("id = {$id} and zt = 1 and user_id = {$user_id}")->setInc('already_profit', $shouyi);
    M('order')->where("id = {$id} and zt = 1 and user_id = {$user_id}")->save($data);

    M('member')->where("id = {$user_id}")->setInc("money", $shouyi);
    account_log($username, $shouyi, '果树收益', 1, 1, 1, $order['id']);
    $shou1 = $shouyi * C('shou1');
    $shou2 = $shouyi * C('shou2');
    $shou3 = $shouyi * C('shou3');
    $parent = M('member')->where(array('username' => $username))->getField('parent');
    $parent1 = M('member')->where(array('username' => $parent))->getField('parent');
    $parent2 = M('member')->where(array('username' => $parent1))->getField('parent');

    M("member")->where(array('username' => $parent))->setInc('money', $shou1);
    account_log($parent, $shou1, '1代生态收益奖励', 1, 2, 1, 0, $username);

    M("member")->where(array('username' => $parent1))->setInc('money', $shou2);
    account_log($parent1, $shou2, '2代生态收益奖励', 1, 2, 1, 0, $username);

    M("member")->where(array('username' => $parent2))->setInc('money', $shou3);
    account_log($parent1, $shou3, '3代生态收益奖励', 1, 2, 1, 0, $username);

    $p_id = M('member')->where("id = {$user_id}")->getField('parent_id');

    $daishu = 3;
    if (!empty($p_id)) {
      for ($i = 1; $i <= $daishu; $i++) {
        $p_userinfo = M('member')->where("id = {$p_id}")->find();
        if (!empty($p_userinfo)) {//$p_userinfo['level']
          if ($p_userinfo['level'] == 1) {//判断是否是城主

            $p_shouyi = $shouyi * (C('shoujj') / 100);
            M('member')->where("id = {$p_id}")->setInc("money", $p_shouyi);
            account_log($p_userinfo['username'], $p_shouyi, $i . '代生态大使额外生态收益奖励-ID8' . $user_id, 1, 2);
          }
          $p_id = $p_userinfo['parent_id'];
          if (empty($p_id)) {
            break;
          }
        } else {
          break;
        }
      }
    }
    $data = array(
      'user_id' => $user_id,
      'profile' => $shouyi,
      'add_time' => time(),
      'scid' => $order['sid']
    );
    M('profile_log')->add($data);
    alert('生态收益领取成功！', U('Robot/robot'));
  }

  public function jiesuan_total()
  {
    //echo json_encode(['code' => 1,'msg'=> '领取收益成功','data' => 86]);die;
    $id = I('get.id', 0, 'intval');

    $user_id = session('mid');
    $username = session('username');
    $robot = M('order')->where(array('user' => $username, 'zt' => 1))->select();
    if (count($robot) == 0) {
      echo json_encode(['code' => 0, 'msg' => '暂无果树', 'data' => 0]);
      die;
    }
    $total_shouyi = 0;
    foreach ($robot as $k => $v) {
      $order = M('order')->where("id = {$v['id']} and zt = 1 and user_id = {$user_id}")->find();

      if (empty($order)) {
        echo json_encode(['code' => 0, 'msg' => '该果树不存在！', 'data' => 0]);
        die;
        //$this->ajaxReturn(array('result'=>0,'info'=>'该村民不存在！'));
      }
      //判断与上次结算时间有没有达到24小时
      $jiesuan_time = C('jiesuan_time');
      if (empty($jiesuan_time)) {
        $jiesuan_time = 24;
      }
      if (time() - $order['UG_getTime'] < $jiesuan_time * 3600) {

        echo json_encode(['code' => 0, 'msg' => '领取收益间隔不到' . $jiesuan_time . '小时！', 'data' => 0]);
        die;
        //alert('领取收益间隔不到'.$jiesuan_time.'小时！',U('Robot/robot'));
      } else {
        $total_shouyi = $total_shouyi + $shouyi;
      }
      //算出已经结算的时间
      $a_time = $order['UG_getTime'] - strtotime($order['addtime']);
      //本次将要结算的时间
      $n_time = time() - $order['UG_getTime'];
      $time = 0;//参加计算的时间；
      $data = array();
      $data['UG_getTime'] = time();
      $is_over = 1;
      if ($a_time + $n_time > $order['yxzq'] * 3600) {
        $time = ($order['yxzq'] * 3600) - $a_time;
        $data['zt'] = 2;
        $is_over = 0;
      } else {
        $time = $n_time;
      }

      $shouyi = $time / 3600 * $order['shouyi'];//本次收益

      M('order')->where("id = {$v['id']} and zt = 1 and user_id = {$user_id}")->setInc('already_profit', $shouyi);
      M('order')->where("id = {$v['id']} and zt = 1 and user_id = {$user_id}")->save($data);

      M('member')->where("id = {$user_id}")->setInc("money", $shouyi);
      account_log($username, $shouyi, '果树收益', 1, 1, 1, $order['id']);
      $shou1 = $shouyi * C('shou1');
      $shou2 = $shouyi * C('shou2');
      $shou3 = $shouyi * C('shou3');
      $parent = M('member')->where(array('username' => $username))->getField('parent');
      $parent1 = M('member')->where(array('username' => $parent))->getField('parent');
      $parent2 = M('member')->where(array('username' => $parent1))->getField('parent');

      M("member")->where(array('username' => $parent))->setInc('money', $shou1);
      account_log($parent, $shou1, '1级收益奖励', 1, 2, 1, 0, $username);

      M("member")->where(array('username' => $parent1))->setInc('money', $shou2);
      account_log($parent1, $shou2, '2级收益奖励', 1, 2, 1, 0, $username);

      M("member")->where(array('username' => $parent2))->setInc('money', $shou3);
      account_log($parent1, $shou3, '3级收益奖励', 1, 2, 1, 0, $username);

      $p_id = M('member')->where("id = {$user_id}")->getField('parent_id');

      $daishu = C('daishu');
      if (!empty($p_id)) {
        for ($i = 1; $i <= $daishu; $i++) {
          $p_userinfo = M('member')->where("id = {$p_id}")->find();
          if (!empty($p_userinfo)) {//$p_userinfo['level']
            if ($p_userinfo['level'] == 1) {//判断是否是城主

              $p_shouyi = C('shoujj');
              M('member')->where("id = {$p_id}")->setInc("money", $p_shouyi);
              account_log($p_userinfo['username'], $p_shouyi, $i . '代/ID号' . $user_id, 1, 2);
            }
            $p_id = $p_userinfo['parent_id'];
            if (empty($p_id)) {
              break;
            }
          } else {
            break;
          }
        }
      }

    }

    $data = array(
      'user_id' => $user_id,
      'profile' => $total_shouyi,
      'add_time' => time(),
      //'scid' => 1
    );
    M('profile_log')->add($data);

    echo json_encode(['code' => 1, 'msg' => '领取收益成功', 'data' => $total_shouyi]);
    die;
    //alert('果树收益领取成功！',U('Robot/robot'));
  }

}

?>