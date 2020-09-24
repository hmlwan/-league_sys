<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>

<html class="pixel-ratio-3 retina android android-5 android-5-0 watch-active-state"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <title>个人中心</title>

    <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
    <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
    <style type="text/css">
    	*{
    		margin: 0;
    		padding: 0;
    		text-decoration: none;
    		list-style: none;
    	}
    </style>
  </head>
  <body style="background: #f6f8fa;">
  	
  	<div class="wode-index-top">
  		<div class="wode-index-top-touxiang">
  		</div>
  		<div class="wode-index-top-mobile">
  			<!--<p class="wode-index-top-mobile-id"><?php echo ($minfo["mobile"]); ?></p>-->
  		</div>
  	</div>
  	
  	
  	
  	<div class="wode-index-center-list">
  		<ul>
  			
  			<a>
  			<li>
  				<p>姓名</p>
  				<p class="wode-index-center-lisrt-a" style="color:#000"><?php echo ($minfo["truename"]); ?></p>
  			</li>
  			</a>
  			<a>
  			<li>
  				<p>身份证</p>
  				  				<p class="wode-index-center-lisrt-a" style="color:#000"><?php echo ($minfo["idcard"]); ?></p>

  			</li>
  			</a>
  			<a>
  			<li>
  				<p>手机号</p>
  				  				<p class="wode-index-center-lisrt-a" style="color:#000"><?php echo ($minfo["username"]); ?></p>

  			</li>
  			</a>
  			

  			
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
					<img src="/public/dianyun/img/i-julebu.png"/>
					<p class="">果树</p>
				</li>
				<a href="<?php echo U('Index/Wallet/index');?>">
				<li>
					<img src="/public/dianyun/img/i-wode-s.png"/>
					<p class="new-index-footer-ac">我的</p>
				</li>
			</a>
		</ul>
	</footer>





</body>
</html>