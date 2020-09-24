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
<body>
    <header>
        <div class="header_bt">
            <div class="header_f"><a href="javascript:history.back()" class="header_fh"></a></div>
            <div class="header_c">528联盟</div>
        </div>
        <div style="height: .74rem;clear: both;"></div>
    </header>
    <div class="xzy_page">
        <div class="xzy_top flexbox wrap">
            <img src="<?php echo ($info["logo_url"]); ?>" alt="">
             <div class="xzy_top_con">
                 <p><span class="title"><?php echo ($info["title"]); ?></span><i class="gf_icon"></i></p>
                 <p class="size"><?php echo ($info["size"]); ?>M</p>
                 <p class="anquan"><i class="aq_icon"></i>人工亲测 · 安全 · 无广告</p>
             </div>
        </div>
        <div class="xzy_con flexbox wrap spacebetween">
            <div>
                <p>
                    <span><?php echo ($info["score"]); ?></span>
                    <span>
                        <?php if($score_arr[0] > 0): $__FOR_START_17969__=0;$__FOR_END_17969__=$score_arr[0];for($i=$__FOR_START_17969__;$i < $__FOR_END_17969__;$i+=1){ ?><img src="/Public/mobile/image/st1.png" class="qx" alt=""><?php } endif; ?>
                        <?php if($score_arr[1] > 0): ?><img src="/Public/mobile/image/st2.png" class="bx" alt=""><?php endif; ?>
                    </span>
                </p>
                <p><?php echo ($info["person_num"]); echo ($info["person_num_unit"]); ?> 人评分</p>
            </div>
            <div>
                <p><?php echo ($info["install_num"]); echo ($info["install_num_unit"]); ?></p>
                <p>次安装</p>
            </div>
            <div>
                <p>18+</p>
                <p>年满18周岁</p>
            </div>
        </div>
        <div class="xzy_scroll">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><img src="/Public/mobile/image/xzy1.png" alt=""></div>
                    <div class="swiper-slide"><img src="/Public/mobile/image/xzy2.jpg" alt=""></div>
                    <div class="swiper-slide"><img src="/Public/mobile/image/xzy1.png" alt=""></div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
        <div class="xzy_xq">
            <?php echo ($info["content"]); ?>
        </div>
        <div class="xzy_btn">
            <p>
                <a href="<?php echo ($info["android_url"]); ?>" target="_blank">安卓下载</a>
            </p>
            <p>
                <a href="<?php echo ($info["ios_url"]); ?>"  target="_blank">苹果下载</a>
            </p>
        </div>
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
    var mySwiper = new Swiper('.swiper-container',{
        slidesPerView : 2,
        spaceBetween : 15,
            pagination: {
                el: '.swiper-pagination',
            }
        }
    )
</script>

</html>