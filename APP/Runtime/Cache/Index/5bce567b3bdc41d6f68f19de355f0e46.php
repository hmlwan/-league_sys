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

  <title>首页</title>


  <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
  <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
  <link rel="stylesheet" href="/Public/css/style.css">
  <script type="text/javascript" src="/Public/js/TouchSlide.1.1.js"></script>
  <style type="text/css">
    @keyframes btnRotate {
      from {
        transform: rotateY(0);
      }
      to {
        transform: rotateY(360deg);
      }
    }

    @keyframes btnRotates {
      from {
        transform: rotateZ(360deg);
      }
      to {
        transform: rotateZ(0);
      }
    }

    * {
      margin: 0;
      padding: 0;
      list-style: none;
    }

    body, html {
      height: 100%;
    }

    div {
      position: absolute;
      height: 100%;
    }

    .img2 {
    	height: 60%;
      top: 40%;
      left: 35%;
    }

    .img3 {
      position: relative;
      height: 70%;
      top: 30%;
      left: 14%;
    }

    .zhuan1{
      transform-origin: center center;
      animation: btnRotates 7s 1s linear infinite forwards;
    }

    .zhuan{
      transform-origin: center center;
      animation: btnRotate 7s 1s linear infinite forwards;
    }
  </style>
</head>
<body>




<div class="img1" ><img src="/public/shu/21.png" alt="" style="width: 100%;
		height: 100%;"></div>
<div class="img2">

			<img class="imgss" src="/public/shu/22.png" alt="">

	</div>
<div class="img3">	<a href="<?php echo U('Index/Robot/pcontent');?>"><img class="imgs" src="/public/shu/23.png" alt="">	</a></div>


<!-- <div class="new-index-right">
  <a href="<?php echo U('Index/New/weikaifang');?>">
    <img src="/public/dianyun/img/i-i-aixinlin.png"/>
  </a>
  <a href="<?php echo U('Index/New/weikaifang');?>">
    <img src="/public/dianyun/img/i-i-chengjiu.png"/>
  </a>
</div>


<div class="new-index-bottom">
  <a href="<?php echo U('Index/New/help');?>">
    <img src="/public/dianyun/img/i-i-tongzhi.png"/>
  </a>
  <a href="<?php echo U('Index/Robot/pcontent');?>"  class="fr">
    <img src="/public/dianyun/img/i-i-zhishu.png"/>
  </a>
  <a href="<?php echo U('Index/Robot/robot');?>"  class="fr" style="margin-right: 0.75rem;">
    <img class="fr" src="/public/dianyun/img/i-i-wodeshu.png"/>
  </a>
</div>
 -->


<footer class="new-index-footer">
  <ul>
    <a href="<?php echo U('Index/New/index');?>">
      <li>
        <img src="/public/dianyun/img/i-shouye-s.png"/>
        <p class="new-index-footer-ac">首页</p>
      </li>
      <a href="<?php echo U('Index/Robot/robot');?>">
        <li>
          <img src="/public/dianyun/img/i-julebu.png"/>
          <p class="">果树</p>
        </li>
        <a href="<?php echo U('Index/Wallet/index');?>">
          <li>
            <img src="/public/dianyun/img/i-wode.png"/>
            <p class="">我的</p>
          </li>
        </a>
  </ul>
</footer>

<script src="/Public/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	var status = "<?php echo ($count); ?>";
	if(status == 1){
		$('.imgs').addClass('zhuan1')
		$('.imgss').addClass('zhuan')
	}
  TouchSlide({
    slideCell: "#slideBox",
    titCell: "#slideBox .hd ul",
    mainCell: "#slideBox .bd ul",
    effect: "leftLoop",
    autoPage: true,
    autoPlay: true,
    interTime: 8000

  });

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

</body>
</html>