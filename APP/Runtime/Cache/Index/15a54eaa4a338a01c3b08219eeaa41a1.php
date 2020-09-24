<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的</title>
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
<body style="background-color: #f4f3fb">
<input type="hidden" name="mui-tab-item" value="4">
<div class="wd_page">
    <div class="wd_box wd_top flexbox wrap">
        <img class="logo" src="/Public/mobile/image/logo.png" alt="">
        <div class="info">
            <p class="name"><?php echo ($m_info["username"]); ?></p>
            <p class="yqm"><span>邀请码：<?php echo ($m_info["inviteCode"]); ?></span><i class="copy copy_btn" data-clipboard-text="<?php echo ($m_info["inviteCode"]); ?>"></i></p>
        </div>
        <div class="sign">
            签到
        </div>
    </div>
    <div class="wd_box wd_nav">
        <ul class="flexbox spacebetween wrap">
            <li>
                <a href="stjf.html">
                    <img src="/Public/mobile/image/jfmx.png" alt="">
                    <span>积分明细</span>
                </a>
            </li>
            <li>
                <a href="lmqb.html">
                    <img src="/Public/mobile/image/qb.png" alt="">
                    <span>联盟钱包</span>
                </a>
            </li>
            <li>
                <a href="yqhy.html">
                    <img src="/Public/mobile/image/yqhy.png" alt="">
                    <span>邀请好友</span>
                </a>
            </li>
            <li>
                <a href="wdtd.html">
                    <img src="/Public/mobile/image/wdtu.png" alt="">
                    <span>我的团队</span>
                </a>
            </li>
        </ul>
    </div>
    <div class="wd_ad">
        <a href="lmjl.html"><img src="/Public/mobile/image/lmjl.png" alt=""></a>
    </div>
    <div class="wd_box wd_item">
        <ul class="flexbox column">
            <li>
                <a href="wddd.html">
                    <span>消费订单</span><i></i>
                </a>
            </li>
            <li>
                <a href="">
                    <span>实名认证</span><i></i>
                </a>
            </li>
            <li>
                <a href="<?php echo U('/index/member/edit_pwd');?>">
                    <span>密码管理</span><i></i>
                </a>
            </li>
            <li>
                <a href="<?php echo U('/index/member/announce');?>">
                    <span>官方公告</span><i></i>
                </a>
            </li>
            <li>
                <a href="<?php echo U('/index/member/help');?>">
                    <span>在线帮助</span><i></i>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="logout()">
                    <span>安全退出</span><i></i>
                </a>
            </li>
        </ul>
    </div>

</div>

<div style="height: .9rem;"></div>
<div class="footer_main">
    <ul>
        <a href="<?php echo U('index/index/index');?>">
            <li class="footer_f1 mui-item">
                首页
            </li>
        </a>
        <a href="">
            <li class="footer_f2 mui-item">
                购物
            </li>
        </a>
        <a href="<?php echo U('index/app/index');?>">
            <li class="footer_f3 mui-item">
                应用
            </li>
        </a>
        <a href="<?php echo U('index/member/index');?>">
            <li class="footer_f4 mui-item">
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
    copy();
    function logout(){
        layer.confirm('确定退出？', {
            title:'提示',
            btn: ['确定'] //按钮
        }, function(){
            window.location.href = "<?php echo U('/index/index/logout');?>";
        }, function(){

        });
    }
</script>
</html>