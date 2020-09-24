<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>

<html lang="en" class="pixel-ratio-3 retina android android-5 android-5-0">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="/Public/dianyun/css/app.css">
  <link rel="stylesheet" href="/Public/dianyun/css/iconfont.css">
  <link rel="stylesheet" href="/Public/dianyun/css/85917441.css">
  <title>网络环境安全检查</title>
  <style type="text/css">
    .login_body_form_a {
      border: none;
      color: #fff;
    }
  </style>
</head>
<body class="login_body">

<div class="login_body_logo">
</div>

<p class="login_body_login_pp">网络环境安全请注册</p>
<div class="login_body_form">
  <form action="<?php echo U('/Index/sem/regsems');?>" method="post">
    <input type="hidden" name="id" value="<?php echo ($uid); ?>">
    <button class="login_body_form_a">去注册</button>
  </form>
</div>


<script src="/Public/bao/jquery.js"></script>
<script src="/Public/bao/light7.js"></script>
<script src="/Public/bao/swiper.js"></script>
<script>

  $(function () {
    $.init();

    var swiper = new Swiper('.redSwiper', {
      init: true,
      direction: 'vertical',
      slidesPerView: 4,
      spaceBetween: 10,
      autoplay: {
        delay: 2000,//1秒切换一次
      },
      speed: 400
    });


    // 点击领取(按钮动画)

    // 按钮动画
    $('.getRed').click(function () {
      $(this).addClass('btnClass')
      setInterval(function () {
        $('.redModal').css('display', function () {
          return 'block'
        })
        $(this).removeClass('btnClass')
      }, 2000)
    })


  })
</script>

</body>
</html>