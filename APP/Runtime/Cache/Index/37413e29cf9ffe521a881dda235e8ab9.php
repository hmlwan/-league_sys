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

  <title>个人中心</title>

  <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
  <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
  <style type="text/css">
    * {
      margin: 0;
      padding: 0;
      text-decoration: none;
      list-style: none;
    }

    .ulliimg a {
      color: #000;
    }
    .spanss{
        width: 50px;
        height: 4px;
        border-radius: 10px;
        float: left;
        margin-left: 1em;
    }
  </style>
</head>
<body style="background: #fff;">
<img src="/Public/shu/banner.png" style="width: 100%;
	  position: absolute;
	  z-index: -1;">
<div class="wode-index-top">
  <div class="wode-index-top-touxiang">
  	<a href="<?php echo U('Wallet/tixian');?>">
  		  	<img id="" src="/Public/shu/tx.png" style="    width: 40px;
    height: 40px;
    position: absolute;
    left: 19rem;
    top: -3rem;" />
  	</a>

    <img id="avatar" src="<?php echo ($avatar); ?>" onclick="document.getElementById('upfile').click()"/>
    <input type="file" name="photoimg" class="webuploader-element-invisible" multiple="multiple" id="upfile"
           style="display: none;">
  </div>
  <div class="wode-index-top-mobile">
    <p class="wode-index-top-mobile-id"><img src="<?php echo ($imgurl); ?>" alt="" style="    position: absolute;
				top: 2.3em;
				width: 30%;
				left: 5em;"></p>
    <p class="wode-index-top-mobile-yqm"><?php echo ($minfo["username"]); ?><span>邀请码：<?php echo ($minfo["inviteCode"]); ?></span></p>
  </div>
  <!-- <a class="wode-index-top-mobile-gg" href="<?php echo U('Index/Index/personal');?>">></a></a> -->
</div>

<div class="wode-index-center-ulli">
  <ul>
    <a href="#">
      <li>
        <div class="wode-index-center-ul-li-d">
          <p style="margin-top: 0.65rem;"><?php echo (number_format($finalTotal, 2, '.', '')); ?></p>
          <p class="spans">总资产(Usdt)</p>
          <div class="spanss" style="background-color: #ff5252;"></div>
      </li>
    </a>

    <a href="#">
      <li>
        <div class="wode-index-center-ul-li-d">
          <p style="margin-top: 0.65rem;"><?php echo ($minfo["money"]); ?></p>
          <p class="spans">可用余额(Usdt)</p>
        <div class="spanss" style="background-color: #fca918;"></div>
      </li>
    </a>

    <a href="#">
      <li>
        <div class="wode-index-center-ul-li-d">
          <p style="margin-top: 0.65rem;"><?php echo (number_format($profitTotal, 2, '.', '')); ?></p>
          <p class="spans">今日收益(Usdt)</p>
          <div class="spanss" style="background-color: #e9db42;"></div>
      </li>
    </a>

  </ul>
</div>
<div class="ulliimg">
  <ul>
    <a href="<?php echo U('Wallet/onlinerecharge');?>">
      <li>
        <img src="/Public/shu/1.png"/>
        <p>资金充值</p>
      </li>
    </a>
    <a href="<?php echo U('Wallet/award');?>">
      <li>
        <img src="/Public/shu/2.png"/>
        <p>收益明细</p>
      </li>
    </a>
    <a href="<?php echo U('Wallet/ecologyaward');?>">
      <li>
        <img src="/Public/shu/3.png"/>
        <p>生态收益</p>
      </li>
    </a>
    <a href="<?php echo U('Index/Index/zhitui');?>">
      <li>
        <img src="/Public/shu/4.png"/>
        <p style="    margin-left: .5rem;">生态圈</p>
      </li>
    </a>
  </ul>
  <div style="width: 100%;
  height: 10px;
  background-color: #efefef;
  margin-top: 30%;
  margin-left: -1em;"></div>
</div>
<div class="ulliimg">
  <ul>
    <a href="<?php echo U('Index/Index/personal');?>">
      <li>
        <img src="/Public/shu/5.png"/>
        <p>个人信息</p>
      </li>
    </a>
    <a href="<?php echo U('Index/New/help');?>">
      <li>
        <img src="/Public/shu/6.png"/>
        <p>系统公告</p>
      </li>
    </a>
    <a href="<?php echo U('index/index/zhifu');?>">
      <li>
        <img src="/Public/shu/7.png"/>
        <p>收款地址</p>
      </li>
    </a>
    <a href="<?php echo U('Index/Index/tgm');?>">
      <li>
        <img src="/Public/shu/8.png"/>
        <p>生态建设</p>
      </li>
    </a>
    <a href="/index.php/index/new/xiangmu">
      <li style=" width: 25%;margin-left: 20px;">
        <img src="/Public/shu/9.png"/>
        <p style="margin-left: .5rem;">帮助中心</p>
      </li>
    </a>
    <a href="<?php echo U('index/login/editpwd');?>">
      <li style="width: 25%;">
        <img src="/Public/shu/10.png"/>
        <p style="margin-left: .5rem;">修改密码</p>
      </li>
    </a>
    <a href="<?php echo U('index/index/logout');?>">
      <li style="width: 25%;">
        <img src="/Public/shu/11.png"/>
        <p style="margin-left: .5rem;">安全退出</p>
      </li>
    </a>
  </ul>
</div>


<!--
  			<div class="wode-index-center-list-hr"></div>

  			<a href="<?php echo U('Index/Index/team');?>">
  			<li>
  				<img src="/public/dianyun/img/i-tuandui.png"/>
  				<p>我的下级</p>
  				<a class="wode-index-center-lisrt-a" href="<?php echo U('Index/Index/team');?>">></a>
  			</li>
  			</a>

  			<a href="<?php echo U('Index/Index/tgm');?>">
  			<li>
  				<img src="/public/dianyun/img/i-zhaomu.png"/>
  				<p>邀请好友</p>
  				<a class="wode-index-center-lisrt-a" href="<?php echo U('Index/Index/tgm');?>">></a>
  			</li>
  			</a>
  			<a href="<?php echo U('Index/New/help');?>">
  			<li>
  				<img src="/public/dianyun/img/i-wenti.png"/>
  				<p>消息中心</p>
  				<a class="wode-index-center-lisrt-a" href="<?php echo U('Index/New/help');?>">></a>
  			</li>
  			</a>

  			<div class="wode-index-center-list-hr"></div>
  			<a href="/index.php/index/new/xiangmu">
  			<li>
  				<img src="/public/dianyun/img/i-xunzhang.png"/>
  				<p>关于我们</p>
  				<a class="wode-index-center-lisrt-a" href="/index.php/index/new/xiangmu">></a>
  			</li>
  			</a>

  		</ul> -->
</div>


<footer class="new-index-footer">
  <ul>
    <a href="<?php echo U('Index/New/index');?>">
      <li>
        <img src="/public/dianyun/img/i-shouye.png"/>
        <p class="">首页</p>
      </li>
      <a href="<?php echo U('Index/Robot/robot');?>">
        <li>
          <img src="/public/dianyun/img/i-julebu.png"/>
          <p class="">果树</p>
        </li>
        <a href="<?php echo U('Index/Wallet/index');?>">
          <li>
            <img src="/public/dianyun/img/i-wode-s.png"/>
            <p class="new-index-footer-ac">我的</p>
          </li>
        </a>
  </ul>
</footer>



<script src="/Public/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
//禁止页面拖动 2020/3/14
  document.body.addEventListener('touchmove', function(e) {
    e.preventDefault(); //阻止默认的处理方式(阻止下拉滑动的效果)
}, {passive: false}); //passive 参数不能省略，用来兼容ios和android
document.onreadystatechange = function() {
    if(document.readyState == "complete") {
        document.body.style.display = "block";
    } else {
        document.body.style.display = "none";
    };
};
</script>


<script src="/Public/js/jquery-1.11.3.min.js"></script>
<script src="/Public/js/jquery.form.js"></script>
<script>
  $(function () {
    $("#upfile").wrap("<form action='<?php echo U('Index/wallet/uploads');?>' method='post' enctype='multipart/form-data'></form>");
    $("#upfile").off().on('change', function () {
      var objform = $(this).parents();
      objform.ajaxSubmit({
        dataType: 'json',
        target: '#preview',
        success: function (data) {
          if (data.result == 1) {
            $("#avatar").attr('src', '/Public/' + data.url)
            alert('头像已更新！');
          } else {
            alert(data.msg);
          }
        },
        error: function () {
        }
      });
    });
  });
</script>

</body>
</html>