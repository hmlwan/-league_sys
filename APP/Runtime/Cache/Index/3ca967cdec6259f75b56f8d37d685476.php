<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
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


</head>
<body class="dlogin-body">
<form id="login-form" action="<?php echo U('/index/login/index');?>" method="post" onsubmit="return false">
    <div class="dlogin_page">
        <img src="/Public/mobile/image/dlogin_top.png" alt="">
        <div class="dlogin_con">
            <p class="reg">还没有账号？ <a href="<?php echo U('/index/login/reg');?>">点击注册</a></p>
            <ul class="dlogin_item">
                <li>
                    <label>手机号</label>
                    <p><em>+86</em><input name="username" class="input_line account" placeholder="请输入您的手机号码" type="text"></p>

                </li>
                <li>
                    <label>密码</label>
                    <p><input  type="password" name="password" class="input_line" placeholder="请输入密码"></p>
                </li>
            </ul>
            <a class="tips" href="<?php echo U('/index/login/editpwd');?>">忘记密码</a>
            <button class="dlogin_sub_button" data-form="login-form" onclick="ajaxPost(this)">登录</button>
        </div>
    </div>
</form>
</body>
<script src="/Public/mobile/js/common/main.js"></script>
<script src="/Public/mobile/js/common/fontSize.js"></script>
<script src="/Public/mobile/js/common/swiper.min.js"></script>
<script src="/Public/mobile/js/common/utils.js"></script>
<script src="/Public/mobile/js/layui/layui.js"></script>
<script src="/Public/mobile/js/layer/layer.js"></script>
<script src="/Public/mobile/js/common/clipboard.min.js"></script>
<script type="text/javascript">
$(function () {
    $(".mui-item").each(function (i) {
        var i = i+1;
        var cur_active_class = "footer_active_f"+i;
        $(this).removeClass(cur_active_class);
        var footer_active = $("input[name='mui-tab-item']").val();
        if(i == footer_active){
            $(this).addClass(cur_active_class);
        }
    })
})
</script>
<script>
    function ajaxLogin(target) {
        var form = $(target).attr('data-form');
        var sub_data = $("#" + form).serialize();
        var show_account = $("input[name='account']",$("#" + form)).val();
        var show_password = $("input[name='password']",$("#" + form)).val();
        var url = $("#" + form).attr('action');
        loading(true)
        $.post(url, sub_data, function (data) {
            loading(false)
            if (data.result == 0) {
                if (data.toUrl) {
                    layer.msg(data.message, '', function () {
                        window.location.href = data.toUrl;
                    })
                } else {
                    layer.msg(data.message, '');
                }
            }else if(data.code == 2){ //安全验证
//                login_send_code(show_account,show_password,data.data);
                $("input[name='account']",$("#logincheck-form")).val(show_account);
                $("input[name='password']",$("#logincheck-form")).val(show_password);
                $(".aqyz-page .mobile").html(data.data);
                $(".aqyz-page").show();
                $(".zhezhao_h").addClass('zhezhao');

            } else {
                if (data.toUrl) {
                    layer.msg(data.message, '', function () {
                        window.location.href = data.toUrl;
                    })
                } else {
                    layer.msg(data.message, '');
                }
            }
        }, 'json')
    }
</script>
</html>