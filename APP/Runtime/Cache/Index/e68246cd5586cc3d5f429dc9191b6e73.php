<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>提现</title>
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
  <p>提现</p>
</div>
<input name="username" type="hidden" value="<?php echo ($username); ?>">
<div class="congzhi_input" style="
padding-top: 44%;
padding-bottom: 40%;
">
  <p class="congzhi_input_title" style="text-align: center;color: #fff;">提现金额</p>
  <p class="congzhi_input_input">
    <input type="text" name="money" id="money" style="text-align: center;color: #fff; background-color: deepskyblue;
    "/><span style="color: #fff;margin-left: 10px;">Usdt</span></p>
  <span style="    font-size: 14px;
        margin-left: 4%;
        color: #fff;
        margin-top: 30px;
        display: inline-block;"><svg t="1583905743476" class="icon" viewBox="0 0 1024 1024" version="1.1"
                                     xmlns="http://www.w3.org/2000/svg" p-id="2022" width="16" height="16"><path
    d="M512 953.81818174c244.02272695 0 441.81818174-197.79545479 441.81818174-441.81818174C953.81818174 267.97727305 756.02272695 70.18181826 512 70.18181826 267.97727305 70.18181826 70.18181826 267.97727305 70.18181826 512c0 244.02272695 197.79545479 441.81818174 441.81818174 441.81818174z m0-65.45454522A376.36363653 376.36363653 0 1 1 512 135.63636347a376.36363653 376.36363653 0 0 1 0 752.72727306z"
    p-id="2023" fill="#ffffff"></path><path
    d="M512 675.63636347m-40.90909131 1e-8a40.90909131 40.90909131 0 1 0 81.81818262 0 40.90909131 40.90909131 0 1 0-81.81818262 0Z"
    p-id="2024" fill="#ffffff"></path><path
    d="M479.27272695 287v277.48636348a32.72727305 32.72727305 0 1 0 65.4545461-1e-8V287a32.72727305 32.72727305 0 1 0-65.4545461 0z"
    p-id="2025" fill="#ffffff"></path></svg>提现到账受区块确认及网络情况影响,预计24小时到账</span>
</div>
<div class="congzhi_ac">
  <div class="congzhi_zhifupingtai" style="margin-top: 10px;">
    <div class="text">
      <p><?php echo ($receive); ?></p>
      <p style="margin-top: 10px;">您的 RRC20 收款维地址</p>
    </div>
  </div>
</div>

<div class="Putforwardbtn">
  <a class="congzhi_liji" id="Confirm">确认提现</a>
</div>

<script src="__PUBLIC__/js/jquery-1.9.1.min.js"></script>
<script src="/public/wx/cz/js/goblak.js"></script>
<script>
  $(function () {
    $('#Confirm').on('click', function () {
      var money = $("input[name='money']").val();
      if (money == '') {
        alert("提现金额不能为空");
        return false;
      }

      $.ajax({
        url: '<?php echo U("Index/Wallet/withpost");?>',
        type: 'POST',
        data: {money: money},
        dataType: 'json',
        success: function (json) {
          if (json.result == 1) {
            window.location.href = '<?php echo U("Index/Wallet/index");?>';
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


</body>
</html>