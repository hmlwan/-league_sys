<?php if (!defined('THINK_PATH')) exit(); if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><div class="gfgg_item">
        <div class="gfgg_con">
            <p><i></i><span class="title"><?php echo ($vo["title"]); ?></span></p>
            <p class="content"><?php echo (htmlspecialchars_decode($vo["content"])); ?></p>
            <p class="time"><?php echo (date("Y-m-d",$vo["addtime"])); ?></p>
        </div>
    </div><?php endforeach; endif; else: echo "" ;endif; ?>