<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!-- saved from url=(0057)http://4.sxhengtaiweiye.com.cn/index.php/index/shop/plist -->
<html class="pixel-ratio-1"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link type="text/css" rel="stylesheet" href="/Public/dianyun/css1/lib.css">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1, minimum-scale=1.0">
    <meta content="telephone=no" name="format-detection">
    <title>购买果树</title>
    <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
    <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
<style>
	.txtt{
		color: #fff;
		display: inline-block;
    height: 50px;
    width: 150px;
    border: 1px solid;
	text-align: center;
	margin-top: 15px;
	}
	.txtt span{
		display: inline-block;
	}
	
	
</style>
</head>
<body style="background: #f6f8fa;">
	
<div class="robot-index-center">
		<ul>
			<?php if(is_array($typeData)): foreach($typeData as $key=>$v): ?><li>
				<img src="<?php echo ($v["thumb"]); ?>" style="position: absolute; z-index: -1;margin:1.5%;    width: 97.5%;">
				<p class="robot-index-center-title" style="margin-top: 5%;margin-left:2%"><?php echo ($v["title"]); ?></p>
				<div class="robot-index-center-left">
					<p style="margin-top: -3%;margin-left:4%">生态周期：<?php echo ($v["yxzq"]); ?> 小时</p>
					<p style="margin-top: -2.5%;margin-left:4%">生态收益：<?php echo ($v["yuji"]); ?> Usdt</p>
					<p style="margin-top: -2.5%;margin-left:4%">剩余数量：<?php echo ($v["stock"]); ?> 棵</p>
					<p style="margin-top: -2.5%;margin-left:4%">限购数量：<?php echo ($v["xiangou"]); ?> 棵</p>
				</div>
				<div class="robot-index-center-right">
					<if condition="$v.zt eq 1">
            		<if condition="$v.is_jiesuan eq 1">
					<a href="<?php echo U('Robot/buy',array('id'=>$v['id']));?>" class="txtt"><span style="margin-top: 3%"><?php echo ($v["price"]); ?>Usdt</span>
					<span>
						认购生态周期
					</span></a>
				</div>
			</li><?php endforeach; endif; ?>
		</ul>
	</div>









	<footer class="new-index-footer">
		<ul>
			<a href="<?php echo U('Index/New/index');?>">
				<li>
					<img src="/public/dianyun/img/i-shouye.png"/>
					<p class="">首页</p>
				</li>
				<a href="<?php echo U('Index/Robot/robot');?>">
				<li>
					<img src="/public/dianyun/img/i-julebu-s.png"/>
					<p class="new-index-footer-ac">果树</p>
				</li>
				<a href="<?php echo U('Index/Wallet/index');?>">
				<li>
					<img src="/public/dianyun/img/i-wode.png"/>
					<p class="">我的</p>
				</li>
			</a>
		</ul>
	</footer>







</body>
</html>