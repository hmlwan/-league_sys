<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>

<html class="pixel-ratio-3 retina android android-5 android-5-0 watch-active-state">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">

  <title>会员注册</title>
  <link rel="stylesheet" href="/Public/dianyun/css/app.css">
  <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
  <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">

</head>
<body class="login_body">

<div class="login_body_logo">
</div>

<div class="login_body_form">
  <form action="" id="myform">
    <input type="hidden" name="parent" id="parent" value="<?php echo ($d_key); ?>">
    <!-- <input type="text" name="id" id="id" value="<?php echo ($e_keyid); ?>" disabled/> -->
    <!--<input type="text" name="id" id="id" value="<?php echo ($e_keyid); ?>" disabled/>-->
    
      	<input type="text" name="username" id="username" placeholder="请输入您的用户名"  maxlength="11"/>
  		<input type="password" name="password" id="password" placeholder="请输入您的密码" />
  		<input type="password" name="password1" id="password1" placeholder="请输入您的密码" />
  		<input type="text" name="truename" id="truename" placeholder="请输入姓名" />
  		    <input type="hidden" name="parent" id="parent" value="<?php echo ($d_key); ?>">

  		<input type="text" name="idcard" id="idcard" placeholder="请输入18位身份证号码" maxlength="18" />
  		<input type="text" name="mobile" id="mobile" placeholder="请输入手机号码" maxlength="11" />
    <!-- <div class="login_body_form_yzm">
      <input type="text" name="code" id="code" placeholder="请输入验证码"/>
      <a href="#" onClick="send_sms_reg_code()">发送验证码</a>
    </div> -->
    <a class="login_body_form_a btn_submit_my" href="javascript:account_reg_commit();">立即注册</a>
  </form>
</div>
<p class="login_body_form_p">
  <a href="<?php echo U('Index/Login/index');?>" class="fr" style="color:#fff">立即登录</a>
</p>


<script src="/Public/js/jquery-1.11.3.min.js"></script>

<script src="/Public/js/jquery-weui.min.js"></script>
<script src="/Public/js/jquery-1.11.3.min.js"></script>
<script src="/Public/js/jquery-weui.min.js"></script>

<script type="text/javascript">
  $(".btn_submit_my").click(function () {

    $.ajax({
      url: '<?php echo U("Index/Sem/regSempost");?>',
      type: 'POST',
      data: $("#myform").serialize(),
      dataType: 'json',
      success: function (json) {
        alert(json.info);
        if (json.result == 1) {
          window.location.href = '<?php echo U("Index/Login/index");?>';
        }
      },
      error: function () {
        alert("网络故障");
      }
    })
  })

</script>

<script type="text/javascript">
  // 发送手机短信
  function send_sms_reg_code() {
    var mobile = $('#mobile').val();
    if (!checkMobile(mobile)) {
      alert('请输入正确的手机号码');
      return;
    }
    var url = "/index.php/index/sem/send_edit_code/mobile/" + mobile;
    $.get(url, function (data) {
      obj = $.parseJSON(data);
      if (obj.status == 1) {
        $('#count_down').attr("disabled", "disabled");
        intAs = 60; // 手机短信超时时间
        jsInnerTimeout('count_down', intAs);
      }
      alert(obj.msg);// alert(obj.msg);

    })
  }

  $('#count_down').removeAttr("disabled");

  //倒计时函数
  function jsInnerTimeout(id, intAs) {
    var codeObj = $("#" + id);
    intAs--;
    if (intAs <= -1) {
      codeObj.removeAttr("disabled");
      codeObj.text("获取验证码");
      return true;
    }

    codeObj.text(intAs + '秒');
    setTimeout("jsInnerTimeout('" + id + "'," + intAs + ")", 1000);
  };

  function checkMobile(tel) {
    var reg = /(^1[3|4|5|7|8][0-9]{9}$)/;
    if (reg.test(tel)) {
      return true;
    } else {
      return false;
    }
    ;
  }
</script>

</body>
</html>