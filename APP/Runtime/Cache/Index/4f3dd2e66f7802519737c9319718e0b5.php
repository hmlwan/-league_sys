<?php if (!defined('THINK_PATH')) exit(); if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><a href="<?php echo ($vo["jump_url"]); ?>">
        <div class="sy_xm_con rmzx_con">
            <div class="sy_xm_item flexbox wrap">
                <img src="<?php echo ($vo["logo_url"]); ?>" alt="">
                <p class="sy_xm_l flexbox column">
                    <span class="name"><?php echo ($vo["name"]); ?></span>
                    <span class="title"><?php echo ($vo["content"]); ?></span>
                </p>
            </div>
        </div>
    </a><?php endforeach; endif; else: echo "" ;endif; ?>