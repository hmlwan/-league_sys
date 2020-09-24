<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>应用</title>
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
<input type="hidden" name="mui-tab-item" value="3">
    <div class="yy_page">
        <div class="yy_top">
            <img src="/Public/mobile/image/yy_top.png" alt="">
        </div>
        <?php if($list): if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><div class="yy_item">
                    <div class="top">
                        <a href="<?php echo U('/index/app/get_more',array('type_id'=>$vo['id']));?>">
                            <p class="more_title flexbox spacebetween">
                                <span><?php echo ($vo["name"]); ?></span>
                                <span class="more">点击查看更多></span>
                            </p>
                        </a>
                    </div>
                    <div class="yy_con flexbox wrap">
                        <?php if(is_array($vo['app_list'])): $i = 0; $__LIST__ = $vo['app_list'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><p onclick="window.location.href='<?php echo ($v["jump_url"]); ?>'">
                                <span><img src="<?php echo ($v["logo_url"]); ?>" alt=""></span>
                                <span><?php echo ($v["name"]); ?></span>
                            </p><?php endforeach; endif; else: echo "" ;endif; ?>
                    </div>
                </div><?php endforeach; endif; else: echo "" ;endif; ?>
        <?php else: ?>
            <div class="show_on_content">
                <p><img src="/Public/mobile/image/no_data_icon.png" alt=""></p>
                <p class="show_text">暂无内容</p>
            </div><?php endif; ?>
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
</html>