<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>提现</title>
		<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="stylesheet" type="text/css" href="/Public/dianyun/css/guoshu.css"/>
    <script src="/public/js/jquery-1.8.3.min.js"></script>
    <script src="/public/js/layer/layer.js"></script>
    <style type="text/css">
    	.congzhi_acc{
    		height: 6rem;
    	}
    	.congzhi_liji{
    		background: #279950;
    	}
    </style>
	</head>
	<body>
		<form action="" method="POST" style="font-size:14px"  id="myform1">
		<div class="congzhi_input">
			<p class="congzhi_input_title">提现金额</p>
			<p class="congzhi_input_input"><span>¥</span><input maxlength="10" type="text" name="money" id="money"  /></p>
		</div>
		<div class="buluoba-hr"></div>
		
		
		<div class="congzhi_ac congzhi_acc">
			<p class="congzhi_input_title">提现账户</p>
			  <select id="type" name="type" maxlength="50" style="color: #279950;width: 100%;height: 2rem;border: none;background: #fff;padding: 0 0.75rem;outline: none;border: none;">
			  	 <option value="" selected="selected" style="outline: none;">请选择</option>
			 <option value="2" style="outline: none;border: none;">支付宝</option>
			</select>
		</div>
		
		<div class="buluoba-hr"></div>
		
		<a href="javascript:bank_modify_commit()"  class="congzhi_liji r_but wi-tix-ttxx" idtype="myform1">提现</a>
		</form>
		
		<script type="text/javascript">
    $(".r_but").click(function(){
        var idtype=$(this).attr("idtype");
        $.ajax({
            url:'<?php echo U("Index/Wallet/withpost");?>',
            type:'POST',
            data:$("#"+idtype).serialize(),
            dataType:'json',
            success:function(json){
                layer.msg(json.info);
                if(json.result ==1){
                    window.location.href=json.url;
                }


            },
            error:function(){

                layer.msg("网络故障");
            }



        })

    })


</script>

<div class="layui-layer layui-anim layui-layer-dialog layui-layer-border layui-layer-msg layui-layer-hui" id="layui-layer1" type="dialog" times="1" showtime="3000" contype="string" style="z-index: 19891015; top: 297.5px; left: 94px;"><div class="layui-layer-content">请正确填写提现金额！</div><span class="layui-layer-setwin"></span></div>
	</body>
</html>