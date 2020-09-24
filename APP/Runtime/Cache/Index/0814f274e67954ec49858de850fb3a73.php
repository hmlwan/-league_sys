<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>找回密码</title>
    <!--申明当前页面的编码集-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!--网页关键词-->
<meta name="keywords" content="" />
<!--网页描述-->
<meta name="description" content="" />
<!--适配当前屏幕-->
<!--<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />-->
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<!--禁止自动识别电话号码-->
<meta name="format-detection" content="telephone=no" />
<!--禁止自动识别邮箱-->
<meta content="email=no" name="format-detection" />
<!--iphone中safari私有meta标签,
    允许全屏模式浏览,隐藏浏览器导航栏-->
<meta name="apple-mobile-web-app-capable" content="yes" />
<!--iphone中safari顶端的状态条的样式black(黑色)-->
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<!--如果用户装了谷歌浏览器，用ie浏览时使用谷歌内核-->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<!--css文件-->
<link type="text/css" rel="stylesheet" href="/Public/mobile/css/reset.css" />
<link type="text/css" rel="stylesheet" href="/Public/mobile/css/swiper.min.css" />
<link type="text/css" rel="stylesheet" href="/Public/mobile/css/style.css" />

<link type="text/css" rel="stylesheet" href="/Public/mobile/js/layui/css/layui.css" />
<script src="/Public/mobile/js/common/jquery1.10.2.min.js"></script>
<script src="/Public/mobile/js/common/main.js"></script>

</head>
<body class="dlogin-body">
<form id="editpwd-form" action="<?php echo U('login/editPwd');?>" method="post" onsubmit="return false">

    <div class="dlogin_page zhma_page zcreg_page">
        <div class="dlogin_con" >
            <p class="reg">已有账号？ <a href="<?php echo U('index');?>">返回登录</a></p>
            <ul class="dlogin_item">
                <li>
                    <label>手机号</label>
                    <p><em>+86</em><input name="username" id="mobile" class="input_line account" placeholder="请输入您的手机号" type="text"></p>
                </li>
                <li>
                    <label>新登录密码</label>
                    <p><input  type="password" name="password" class="input_line" placeholder="请输入新的登录密码"></p>
                </li>
                <li>
                    <label>确认登录密码</label>
                    <p><input  type="password" name="repassword" class="input_line" placeholder="请输入新的登录密码"></p>
                </li>
                <li class="yzm">
                    <label>短信验证码</label>
                    <div class="flexbox spacebetween">
                        <input type="text" class="input_line " name="code" placeholder="请输入短信验证码">
                        <button class="get_yzm" data-mobile="mobile" id="send-code" data-url="<?php echo U('sem/send_edit_code',array('token'=>$token));?>" onclick="sendCode(this)">获取验证码</button>
                    </div>
                </li>
            </ul>
            <button class="dlogin_sub_button" data-form="editpwd-form" onclick="ajaxPost(this)">修改</button>
        </div>
    </div>
</form>
</body>
<script src="/Public/mobile/js/common/fontSize.js"></script>
<script src="/Public/mobile/js/common/swiper.min.js"></script>
<script src="/Public/mobile/js/common/utils.js"></script>
<script src="/Public/mobile/js/layer/layer.js"></script>
<script src="/Public/mobile/js/layui/layui.js"></script>
<script src="/Public/mobile/js/common/clipboard.min.js"></script>

</html>