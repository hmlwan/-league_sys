<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>充值</title>
  <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <script src="/public/wx/cz/js/jquery.min.js"></script>
  <script src="/public/wx/cz/js/swiper.min.js"></script>
  <script src="/public/wx/cz/js/rem.js"></script>
  <script src="/public/wx/cz/js/safari.js"></script>
  <link rel="stylesheet" type="text/css" href="/Public/dianyun/css/guoshu.css"/>
  <style type="text/css">
    .congzhi_ac {
      height: 8rem;
    }

    .congzhi_liji {
      border: none;
    }

    .congzhi_liji {
      background: #00bfff;
    }

    .headers {
      width: 100%;
      height: 50px;
      text-align: center;
      background-color: deepskyblue;
      color: #fff;

    }

    .headers p {
      padding-top: 10px;
    }

    #skmimg {
      width: 50%;
      height: 50%;
      margin-left: 25%;
    }

    .text {
      font-size: 14px;
      text-align: center;
    }

    .text p:last-child {
      margin-left: 15%;
    }
  </style>
</head>
<body>
<div class="headers">
  <p>充值</p>
</div>
<form action="/index.php/Index/Wallet/payConfirm" method="post" onsubmit="return false;">
<input name="username" type="hidden" value="<?php echo ($username); ?>">
<div class="congzhi_input">
  <p class="congzhi_input_title" style="text-align: center;color: #fff;">充值金额</p>
  <p class="congzhi_input_input">
    <input type="text" name="money" id="money" style="text-align: center;color: #fff; background-color: deepskyblue;
    "/><span style="color: #fff;margin-left: 10px;">Usdt</span></p>
  <span style="    font-size: 14px;
      margin-left: 15%;
      color: #fff;
      margin-top: 30px;
      display: inline-block;"><svg t="1583905743476" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                   xmlns="http://www.w3.org/2000/svg" p-id="2022" width="16" height="16"><path
    d="M512 953.81818174c244.02272695 0 441.81818174-197.79545479 441.81818174-441.81818174C953.81818174 267.97727305 756.02272695 70.18181826 512 70.18181826 267.97727305 70.18181826 70.18181826 267.97727305 70.18181826 512c0 244.02272695 197.79545479 441.81818174 441.81818174 441.81818174z m0-65.45454522A376.36363653 376.36363653 0 1 1 512 135.63636347a376.36363653 376.36363653 0 0 1 0 752.72727306z"
    p-id="2023" fill="#ffffff"></path><path
    d="M512 675.63636347m-40.90909131 1e-8a40.90909131 40.90909131 0 1 0 81.81818262 0 40.90909131 40.90909131 0 1 0-81.81818262 0Z"
    p-id="2024" fill="#ffffff"></path><path
    d="M479.27272695 287v277.48636348a32.72727305 32.72727305 0 1 0 65.4545461-1e-8V287a32.72727305 32.72727305 0 1 0-65.4545461 0z"
    p-id="2025" fill="#ffffff"></path></svg>每天单笔充值金额不超过10,000.00 Usdt</span>
</div>
<div class="congzhi_ac">
  <p class="congzhi_input_title" style="text-align: center;color: #000;font-weight: 500;">东鸿益森生态收款二维码</p>
  <div class="congzhi_zhifupingtai">
    <img src="/Public/shu/1.jpg" alt="" id="skmimg">
    <div class="text">
      <p>VcU6wTLnx7RCnmZBNARHFCEgWTnxn34LuSd</p>
      <p>东鸿益森生态收款地址</p>
    </div>
  </div>
</div>
<div class="congzhi_zhifupingtai" style="margin-top: 20px;">
  <span style="font-size: 14px;">转账完成后请截图将图片凭证上传至东鸿益森确认</span>
  <a href="#" style="    display: block;
text-align: center;
font-size: 15px;" onclick="document.getElementById('upfile').click()">充值凭证上传
    <svg t="1583905979065" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
         p-id="3272" width="16" height="16">
      <path d="M320 205.248L365.248 160l342.624 342.624-342.624 342.624L320 800l297.376-297.376z" fill="#1296db"
            p-id="3273"></path>
    </svg>
  </a>
  <input id="imageUrl" name="imageUrl" style="display: none" value="" />
</div>
<div class="Putforwardbtn">
  <button class="congzhi_liji" id="payConfirm">立即充值</button>
</div>
</form>

<input type="file" name="photoimg" class="webuploader-element-invisible" multiple="multiple" id="upfile"
       style="display: none;">


<script src="/public/wx/cz/js/goblak.js"></script>
<script src="/Public/js/jquery-1.11.3.min.js"></script>
<script src="/Public/js/jquery.form.js"></script>
<script>
  $(function () {
    $('#payConfirm').on('click', function () {
      var money = $("input[name='money']").val();
      var username = $("input[name='username']").val();
      var imageUrl = $("input[name='imageUrl']").val();
      if (money == '') {
        alert("充值金额不能为空");
        return false;
      }
      if (username == '') {
        alert("非法操作");
        return false;
      }
      if (imageUrl == '') {
        alert("请上传充值凭证");
        return false;
      }

      $.ajax({
        url: '<?php echo U("Index/Wallet/payConfirm");?>',
        type: 'POST',
        data: {money: money,imageUrl: imageUrl},
        dataType: 'json',
        success: function (json) {
          if (json.result == 1) {
            alert("提交成功，请等候审核！");
            window.location.href = '/index.php/index/wallet/index';
          } else {
            alert(json.info);
          }
        },
        error: function () {
          alert("网络故障");
        }
      })


    });
  });
</script>
<script>
  $(function () {
    $("#upfile").wrap("<form action='<?php echo U('Index/wallet/uploadsRecharge');?>' method='post' enctype='multipart/form-data'></form>");
    $("#upfile").off().on('change', function () {
      var objform = $(this).parents();
      objform.ajaxSubmit({
        dataType: 'json',
        target: '#preview',
        success: function (data) {
          if (data.result == 1) {
            $("#imageUrl").attr('value', '/Public/' + data.url)
            alert('凭证上传成功！');
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