<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>密码管理</title>
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
<body style="background-color: #f2f2f2">
<input type="hidden" name="mui-tab-item" value="4">
    <header>
        <div class="header_bt">
            <div class="header_f"><a href="<?php echo U('index');?>" class="header_fh"></a></div>
            <div class="header_c">密码管理</div>
        </div>
        <div style="height: .74rem;clear: both;"></div>
    </header>
    <form id="editpwd-form" action="<?php echo U('member/edit_pwd');?>" method="post" onsubmit="return false">
        <input type="hidden" id="mobile" name="username" value="<?php echo ($mobile); ?>">
        <input type="hidden" name="type" value="1">
        <div class="smrz_page dlogin_page zcreg_page mmgl_page">
        <div class="dlogin_con smrz_con">
            <p class="nav flexbox spacebetween">
                <a href="javascript:;" class="active">登录密码</a>
                <a href="<?php echo U('edit_trade_pwd');?>">支付密码</a>
            </p>
            <ul class="dlogin_item">
                <li>
                    <label>登录密码</label>
                    <p><input  class="input_line" name="password" placeholder="请输入登录密码" type="password"><i class="eye" onclick="openeye($(this));" data-active="0"> </i></p>
                </li>
                <li>
                    <label>确认密码</label>
                    <p><input  class="input_line" name="repassword" placeholder="请再次输入登录密码" type="password"><i class="eye" onclick="openeye($(this));" data-active="0"></i></p>
                </li>
                <li class="yzm">
                    <label>短信验证码</label>
                    <div class="flexbox spacebetween">
                        <input type="text" name="code" class="input_line " placeholder="请输入短信验证码">
                        <button class="get_yzm" data-mobile="mobile" id="send-code" data-url="<?php echo U('sem/send_edit_code',array('token'=>$token));?>" onclick="sendCode(this)">获取验证码</button>
                    </div>
                </li>
            </ul>
        </div>
        <button class="dlogin_sub_button" data-form="editpwd-form" onclick="ajaxPost(this)">确认修改</button>
    </div>
    </form>
<div style="height: .9rem;"></div>
<div class="footer_main">
    <ul>
        <a href="">
            <li class="footer_f1 mui-item">
                首页
            </li>
        </a>
        <a href="">
            <li class="footer_f2 mui-item">
                购物
            </li>
        </a>
        <a href="">
            <li class="footer_f3 mui-item">
                应用
            </li>
        </a>
        <a href="<?php echo U('index/member/index');?>">
            <li class="footer_active_f4 mui-item">
                我的
            </li>
        </a>
    </ul>
</div>
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

</script>
</html>