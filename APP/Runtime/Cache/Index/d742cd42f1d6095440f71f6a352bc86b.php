<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>

<html class="pixel-ratio-3 retina android android-5 android-5-0 watch-active-state"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <title>关于我们</title>

    <link rel="stylesheet" href="/Public/dianyun/css/app.css">
    <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
     <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
     <style type="text/css">
     	body{
     		background: #f6f8fa;
     	}
     </style>
  </head>
  <body>
  	
  	<div class="help-index">
  		<ul>
  			<?php if(is_array($new)): foreach($new as $key=>$v): ?><a href="<?php echo U('Index/New/xiangqing',array('id'=>$v['id']));?>">
  			<li>
  				<p class="htlp-index-title"><?php echo ($v["title"]); ?></p>
  				<p class="help-index-xx">点击详细查看更多内容</p>
  				<a class="help-index-a" href="<?php echo U('Index/New/xiangqing',array('id'=>$v['id']));?>">查看更多<span>></span></a>
  			</li>
  			</a><?php endforeach; endif; ?>
  		</ul>
  	</div>
  	
  	

</body>
</html>