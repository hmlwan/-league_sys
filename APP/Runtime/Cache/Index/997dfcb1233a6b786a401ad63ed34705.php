<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>我的收益</title>
		<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="stylesheet" type="text/css" href="/Public/dianyun/css/guoshu.css"/>
    <style type="text/css">
    	.award-index-ycc a{
    		color: #279950;
    	}
    </style>
	</head>
	<body>
		
		<div class="tixian-log-top">
			<p>累计收益<a href="#" style="font-size: 12px;">(不计推广收入)</a><span><?php echo ($shouyi); ?>Usdt</span></p>
		</div>
		<div class="buluoba-hr"></div>
		
		<div class="tixian-lot-center">
			<ul>
				<?php if(is_array($list)): foreach($list as $key=>$v): ?><li>
					<p class="tixian-log-p">
						<img src="/Public/dianyun/img/logo.png"/>
						<span><?php echo ($v["desc"]); ?></span>
						<a href="#"><?php if($v["adds"] == 0.00): ?>-<?php echo (two_number($v["reduce"])); else: ?>+<?php echo (two_number($v["adds"])); endif; ?></a>
					</p>
					<p class="tixian-log-pp tixian-log-ppp">详情：<?php echo ($v["desc"]); ?></p>
					<p class="tixian-log-pp">时间：<?php echo (date('Y-m-d',$v["addtime"])); ?></p>
				</li><?php endforeach; endif; ?>
			</ul>
		</div>
		
		<div class="award-index-ycc" style="width: 100%;color: #000;float: left; height: 2.5rem;line-height: 2.5rem;text-align: center;">
   	<?php echo ($page); ?>
   </div>
		
	</body>
</html>