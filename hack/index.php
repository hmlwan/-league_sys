<?php
/* *
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 */

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
  <meta charset="UTF-8">
  <title>充值</title>
  <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <script src="/public/wx/cz/js/jquery.min.js"></script>
  <script src="/public/wx/cz/js/swiper.min.js"></script>
  <script src="/public/wx/cz/js/rem.js"></script>
  <script src="/public/wx/cz/js/safari.js"></script>
  <link rel="stylesheet" type="text/css" href="/Public/dianyun/css/guoshu.css"/>
  <style type="text/css">
    .congzhi_ac {
      height: 8rem;
    }

    .congzhi_liji {
      border: none;
    }

    .congzhi_liji {
      background: #279950;
    }
  </style>
  </head>
<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=4>
        <form name=alipayment action=epayapi.php method=post target="_blank">
    	  <input size="30" type="hidden" name="out_trade_no" value="<?php echo date("YmdHis").mt_rand(100,999); ?>"/>
        	<div class="congzhi_input">
			  <p class="congzhi_input_title">充值金额</p>
			  <p class="congzhi_input_input"><span>¥</span>
			  <input type="text" name="money" id="money"/></p>
			</div>
<div class="congzhi_ac">
  <p class="congzhi_input_title">请选择充值平台</p>
  <div class="congzhi_zhifupingtai">

    <select name="type" id="type" style="
    width:100%;
    font-size: 19px;
    background-color: #fff;
    color: #444;
    border: 1px solid #aaa;
    text-shadow: none;
    border-radius: 4px;">
      <option value="alipay">支付宝</option>
      <option value="wechat">微信</option>
      <option value="qqpay">QQ钱包</option>
    </select>
  </div>
</div>
<div class="Putforwardbtn">
  <button class="congzhi_liji">立即充值</button>
</div>
                   
</body>
</html>