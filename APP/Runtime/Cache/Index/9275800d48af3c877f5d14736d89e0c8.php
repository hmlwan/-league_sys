<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>

<html class="pixel-ratio-3 retina android android-5 android-5-0 watch-active-state"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <title>领金币</title>
    
    <link rel="stylesheet" href="/Public/dianyun/css/app.css">
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
  <body style="background: #fff;">
  	
  	<div class="yqhy">
  	
  	</div>
  	
  	
  	<div class="yqhyxxxq">
  		<p class="yqhywdjb">我的金币<?php echo ($jifen); ?></p>
  		 <a class="dhjqr" href="<?php echo U('Index/Task/duihuan');?>">兑换果树</a>
  		 
  		 
  		 <ul class="yqhyxq_list">
  		 	<li>
  		 		<a href="<?php echo U('Index/index/fenxiang');?>">下载素材</a>
  		 	</li>
  		 	
  		 	<li>
  		 		<a href="<?php echo U('Index/Task/complete');?>">上传截图</a>
  		 	</li>
  		 	
  		 	<li>
  		 		<a href="<?php echo U('Index/Task/completelog');?>">金币明细</a>
  		 	</li>
  		 	
  		 </ul>
  		 
  		 <div class="xxxxsm">
  		 <p>1.先点击复制推广文案.然后点击下载素材,保存你喜欢的素材后打开微信APP进入朋友圈发送</p>
  		 <p>2.金币满<?php echo ($duihuan); ?>个即可兑换一台智能果树，每天为你赚取600-2000个点击流量。</p>
  		 <p>3.通过发圈领金币中获取发圈图片，并发布到您的朋友圈保留两个小时以上，然后截图上传，公司平台审核后，即可获得随机数量的金币。</p>
  		 </div>
  		 
  		 
  		 
  		 <a class="yqhyzzzq" href="<?php echo U('Index/Index/tgm');?>">去邀请好友赚钱？</a>
  		 
  		 
  		 
  		 <p class="yyymdxl">嘤嘤嘤~~~没东西啦</p>
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  		 
  	</div>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
<script type="text/javascript">
function copyText(obj){
	try{
		var rng = document.body.createTextRange();
		rng.moveToElementText(obj);
		rng.scrollIntoView();
		rng.select();
		rng.execCommand("Copy");
		rng.collapse(false);
		alert("已经复制到粘贴板!你可以使用Ctrl+V 贴到需要的地方去了哦!");
	}catch(e){
		alert("您的浏览器不支持此复制功能，请选中相应内容并使用Ctrl+C进行复制!");
	}
}
</script>


</body></html>