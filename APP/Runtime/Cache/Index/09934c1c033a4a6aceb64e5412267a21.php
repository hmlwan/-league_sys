<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
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
<body style="background-color: #eeebef">
<input type="hidden" name="mui-tab-item" value="1">
    <div class="sy_page">
        <div class="sy_top">
           <div class="sy_top_con flexbox  wrap spacebetween">
               <p>
                   <span>生态积分</span>
                   <span class="st_num">1574.<em>87</em> </span>
               </p>
               <p>
                   <span>联盟积分</span>
                   <span class="lm_num">123.<em>3233</em></span>
               </p>
           </div>
           <div class="djlq">
               <i></i>
           </div>
        </div>
        <div class="sy_box sy_rm">
            <p class="sy_rm_con flexbox wrap spacebetween">
                <a href="<?php echo U('/index/index/contract_address');?>">
                    <img src="/Public/mobile/image/heyuedizhi.png" alt="">
                    <span>合约地址</span>
                </a>
                <a href="<?php echo U('/index/index/white_paper');?>">
                    <img src="/Public/mobile/image/baipishu.png" alt="">
                    <span>白皮书</span>
                </a>
                <a href="<?php echo U('/index/index/economic_book');?>">
                    <img src="/Public/mobile/image/jingjishu.png" alt="">
                    <span>经济书</span>
                </a>
                <a href="">
                    <img src="/Public/mobile/image/yaoqinghaoyou.png" alt="">
                    <span>邀请好友</span>
                </a>
            </p>
        </div>
        <div class="sy_box sy_zx">
            <div class="top">
                <?php if($zx_count > 4): ?><a href="<?php echo U('/index/index/get_more',array('type_id'=>1));?>">
                        <p class="more_title flexbox spacebetween">
                            <span>热门咨询</span>
                            <span class="more">点击查看更多></span>
                        </p>
                    </a>
                <?php else: ?>
                    <a href="javascript:;">
                        <p class="more_title flexbox spacebetween">
                            <span>热门咨询</span>
                        </p>
                    </a><?php endif; ?>
            </div>
            <p class="sy_zx_con flexbox wrap">
                <?php if(is_array($zx_list)): $k1 = 0; $__LIST__ = $zx_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v1): $mod = ($k1 % 2 );++$k1;?><a href="<?php echo ($v1["jump_url"]); ?>" <?php if($k1 == 1): ?>class="active"<?php endif; ?>  >
                        <i class="b<?php echo ($k1); ?>_icon"> </i>
                        <span class="title"><?php echo ($v1["name"]); ?></span>
                        <span><?php echo ($v1["summary"]); ?></span>
                    </a><?php endforeach; endif; else: echo "" ;endif; ?>
            </p>
        </div>
        <div class="sy_box sy_xm">
            <div class="top">
                <?php if($jys_count > 3): ?><a href="<?php echo U('/index/index/get_more',array('type_id'=>2));?>">
                        <p class="more_title flexbox spacebetween">
                            <span>热门交易所</span>
                            <span class="more">点击查看更多></span>
                        </p>
                    </a>
                <?php else: ?>
                    <a href="javascript:;">
                        <p class="more_title flexbox spacebetween">
                            <span>热门交易所</span>
                        </p>
                    </a><?php endif; ?>

            </div>
            <?php if(is_array($jys_list)): $i = 0; $__LIST__ = $jys_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v2): $mod = ($i % 2 );++$i;?><div class="sy_xm_con">
                    <a href="<?php echo ($v2["jump_url"]); ?>">
                        <div class="sy_xm_item flexbox wrap">
                            <img src="<?php echo ($v2["logo_url"]); ?>" alt="">
                            <p class="sy_xm_l flexbox column">
                                <span class="title"><?php echo ($v2["summary"]); ?></span>
                                <span class="zz"><?php echo ($v2["operator"]); ?></span>
                            </p>
                        </div>
                    </a>

                </div><?php endforeach; endif; else: echo "" ;endif; ?>
        </div>
        <div class="sy_box sy_xmm">
            <div class="top">
                <?php if($xm_count > 3): ?><a href="<?php echo U('/index/index/get_more',array('type_id'=>3));?>">
                        <p class="more_title flexbox spacebetween">
                            <span>热门项目</span>
                            <span class="more">点击查看更多></span>
                        </p>
                    </a>
                    <?php else: ?>
                    <a href="javascript:;">
                        <p class="more_title flexbox spacebetween">
                            <span>热门项目</span>
                        </p>
                    </a><?php endif; ?>
            </div>
            <div class="sy_xmm_con flexbox wrap">
                <?php if(is_array($xm_list)): $i = 0; $__LIST__ = $xm_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v3): $mod = ($i % 2 );++$i;?><p>
                            <a href="<?php echo ($v3["jump_url"]); ?>">
                            <img src="<?php echo ($v3["logo_url"]); ?>" alt="">
                            <span><?php echo ($v3["name"]); ?></span>
                            </a>
                        </p><?php endforeach; endif; else: echo "" ;endif; ?>
            </div>
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
</html>