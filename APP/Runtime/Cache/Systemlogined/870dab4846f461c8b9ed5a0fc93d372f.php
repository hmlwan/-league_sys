<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title></title>

		<meta name="description" content="Minimal empty page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!--basic styles-->
		<link rel="stylesheet" href="assets/css/chosen.css" />
		<link href="__PUBLIC__/css/bootstrap.min.css" rel="stylesheet" />
		<link href="__PUBLIC__/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="__PUBLIC__/css/font-awesome.min.css" />

		<link rel="stylesheet" href="__PUBLIC__/kindeditor/themes/default/default.css" />
		<script charset="utf-8" src="__PUBLIC__/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="__PUBLIC__/kindeditor/lang/zh_CN.js"></script>

		<script type="text/javascript" src="__PUBLIC__/My97DatePicker/WdatePicker.js"></script>

		<!--自定义样式-->
		<link rel="stylesheet" href="__PUBLIC__/css/custom.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="__PUBLIC__/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!--page specific plugin styles-->

		<!--bbc styles-->

		<link rel="stylesheet" href="__PUBLIC__/css/bbc.min.css" />
		<link rel="stylesheet" href="__PUBLIC__/css/bbc-responsive.min.css" />
		<link rel="stylesheet" href="__PUBLIC__/css/bbc-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="__PUBLIC__/css/bbc-ie.min.css" />
		<![endif]-->
	</head>

	<body>
		<!--导航-->
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<div class="container-fluid">
					<a href="#" class="brand">
						<small>
							<i class="icon-leaf"></i>
							果树管理系统
						</small>
					</a><!--/.brand-->

					<ul class="nav ace-nav pull-right">




						<li class="light-blue user-profile">
							<a data-toggle="dropdown" href="#" class="user-menu dropdown-toggle">
								<img class="nav-user-photo" src="__PUBLIC__/avatars/avatar2.png"/>
								<span id="user_info">
									<small>管理员</small>
									<?php echo (session('adminusername')); ?>
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer" id="user_menu">
								<li>
									<a href="<?php echo U(GROUP_NAME.'/Index/Logout');?>">
										<i class="icon-off"></i>
										安全退出
									</a>
								</li>
							</ul>
						</li>
					</ul><!--/.ace-nav-->
				</div><!--/.container-fluid-->
			</div><!--/.navbar-inner-->
		</div>
        
        
<style>
#page_search input{ border:0px; background:#ccc;color:#ffffff; margin-left:5px;}
#page_search .current{ background:#005580; color:#ffffff;}
.page a{font-size:16px;}
a.active{ color:#C30 !important; font-size:18px;}

</style>        
        

		<div class="container-fluid" id="main-container">
			<a id="menu-toggler" href="#">
				<span></span>
			</a>
			<!--边栏-->
			<div id="sidebar">
<?php $acc = session("_ACCESS_LIST");?>
				<div id="sidebar-shortcuts">
				
					<div id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>
				</div><!--#sidebar-shortcuts-->

				<ul class="nav nav-list">
					<li>
						<a href="<?php echo U(GROUP_NAME.'/Index/index');?>">
							<i class="icon-dashboard"></i>
							<span>首页</span>
						</a>
					</li>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Member')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="Memberuncheck_Membercheck" <?php if(MODULE_NAME == 'Member'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-edit"></i>
							<span>会员管理</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'Member'): ?>style="display: block;"<?php endif; ?>>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Member')][strtoupper('check')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Membercheck">
								<a href="<?php echo U(GROUP_NAME.'/Member/check');?>">
									<i class="icon-double-angle-right"></i>
									会员列表
								</a>
							</li><?php endif; ?>
	<li url="Memberuncheck">
		<a href="<?php echo U(GROUP_NAME.'/Member/shuadan');?>">
			<i class="icon-double-angle-right"></i>
			刷单数量
		</a>
	</li>
	<li url="Memberuncheck">
		<a href="<?php echo U(GROUP_NAME.'/Member/lockuser');?>">
			<i class="icon-double-angle-right"></i>
			封停会员
		</a>
	</li>


	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Member')][strtoupper('shu_list')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><!--<li url="Membercheck">-->
							<!--	<a href="<?php echo U(GROUP_NAME.'/Member/shu_list');?>">-->
							<!--		<i class="icon-double-angle-right"></i>-->
							<!--		团队树形图-->
							<!--	</a>-->
							<!--</li>--><?php endif; ?>	

							<li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Member/gaward');?>">
									<i class="icon-double-angle-right"></i>
									赠送果树
								</a>
							</li>

							<li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Member/awardlist');?>">
									<i class="icon-double-angle-right"></i>
									发放奖励记录
								</a>
							</li>

						
						</ul>
					</li><?php endif; ?>

<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Dai')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li <?php if(MODULE_NAME == 'Dai'): ?>class="open"<?php endif; ?>>
	<a href="#" class="dropdown-toggle">
		<i class="icon-book"></i>
		<span class="menu-text"> 发圈任务 </span>

		<b class="arrow icon-angle-down"></b>
	</a><?php endif; ?>

	<ul class="submenu" <?php if(MODULE_NAME == 'Task'): ?>style="display: block;"<?php endif; ?>>

	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('complete')][strtoupper('complete')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li>
			<a href="<?php echo U(GROUP_NAME.'/Task/complete');?>">
				<i class="icon-double-angle-right"></i>
				完成审核
			</a>
		</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('yescomplete')][strtoupper('yescomplete')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li>
			<a href="<?php echo U(GROUP_NAME.'/Task/yescomplete');?>">
				<i class="icon-double-angle-right"></i>
				已完成任务
			</a>
		</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('notcomplete')][strtoupper('notcomplete')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li>
			<a href="<?php echo U(GROUP_NAME.'/Task/notcomplete');?>">
				<i class="icon-double-angle-right"></i>
				已失败任务
			</a>
		</li><?php endif; ?>
		</ul>
		</li>
	</if>

<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Shop')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="top"  <?php if(MODULE_NAME == 'Shop'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-random"></i>
							<span>果树管理</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'Shop'): ?>style="display: block;"<?php endif; ?>>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Banner')][strtoupper('type_list')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Shop/banner');?>">
									<i class="icon-double-angle-right"></i>
									首页滚动横幅
								</a>
							</li><?php endif; ?>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Shop')][strtoupper('type_list')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Shop/type_list');?>">
									<i class="icon-double-angle-right"></i>
									分类列表
								</a>
							</li><?php endif; ?>	
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Shop')][strtoupper('lists')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Shop/lists');?>">
									<i class="icon-double-angle-right"></i>
									果树列表
								</a>
							</li><?php endif; ?>					
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Shop')][strtoupper('orderlist')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Memberuncheck">
								<a href="<?php echo U(GROUP_NAME.'/Shop/orderlist');?>">
									<i class="icon-double-angle-right"></i>
									已购果树
								</a>
							</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Shop')][strtoupper('editshouyi')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Memberuncheck">
			<a href="<?php echo U(GROUP_NAME.'/Shop/editshouyi');?>">
				<i class="icon-double-angle-right"></i>
				修改收益
			</a>
		</li><?php endif; ?>
	</ul>
					</li><?php endif; ?>						
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="Bonusindex_Jinbidetailindex_JinbidetailjinbiAddList_Jinzhongzidetailindex" <?php if(MODULE_NAME == 'Jinbidetail'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-calendar"></i>
							<span>资金管理</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'Jinbidetail'): ?>style="display: block;"<?php endif; ?>>

				
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')][strtoupper('index')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Jinbidetailindex">
								<a href="<?php echo U(GROUP_NAME.'/Jinbidetail/index');?>">
									<i class="icon-double-angle-right"></i>
									财务明细
								</a>
							</li><?php endif; ?>

<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')][strtoupper('index')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Jinbidetailindex">
								<a href="<?php echo U('Jinbidetail/index',array('type'=>1));?>">
									<i class="icon-double-angle-right"></i>
									果树收益
								</a>
	
						</li><?php endif; ?>	
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')][strtoupper('qjinbi')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Jinbidetailindex">
								<a href="<?php echo U(GROUP_NAME.'/Jinbidetail/qjinbi');?>">
									<i class="icon-double-angle-right"></i>
									冻结明细
								</a>
							</li><?php endif; ?>	
						
 <?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')][strtoupper('paylists')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="JinbidetailjinbiAddList">
								<a href="<?php echo U(GROUP_NAME.'/Jinbidetail/paylist');?>">
									<i class="icon-double-angle-right"></i>
									充值管理
								</a>
							</li><?php endif; ?> 


<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Jinbidetail')][strtoupper('emoneyWithdraw')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="JinbidetailjinbiAddList">
								<a href="<?php echo U(GROUP_NAME.'/Jinbidetail/emoneyWithdraw');?>">
									<i class="icon-double-angle-right"></i>
									提现管理
								</a>
							</li><?php endif; ?>

						</ul>
					</li><?php endif; ?>					
					
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Info')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="Infoannounce_InfoannType_InfomsgReceive_InfomsgSend" <?php if(MODULE_NAME == 'Info'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-list-alt"></i>
							<span>信息交流</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'Info'): ?>style="display: block;"<?php endif; ?>>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Info')][strtoupper('announce')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Infoannounce">
								<a href="<?php echo U(GROUP_NAME.'/Info/announce');?>">
									<i class="icon-double-angle-right"></i>
									公告管理
								</a>
							</li><?php endif; ?>							
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Info')][strtoupper('annType')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="InfoannType">
								<a href="<?php echo U(GROUP_NAME.'/Info/annType');?>">
									<i class="icon-double-angle-right"></i>
									公告类别
								</a>
							</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Info')][strtoupper('xiangmu')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="InfoannType">
			<a href="<?php echo U(GROUP_NAME.'/Info/xiangmu');?>">
				<i class="icon-double-angle-right"></i>
				项目说明
			</a>
		</li><?php endif; ?>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Info')][strtoupper('msgReceive')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="InfomsgReceive">
								<a href="<?php echo U(GROUP_NAME.'/Info/msgReceive');?>">
									<i class="icon-double-angle-right"></i>
									聊天室
								</a>
							</li><?php endif; ?>

	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Application')][strtoupper('app')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Infoannounce">
			<a href="<?php echo U(GROUP_NAME.'/Application/app');?>">
				<i class="icon-double-angle-right"></i>
				应用管理
			</a>
		</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Application')][strtoupper('appType')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="InfoannType">
			<a href="<?php echo U(GROUP_NAME.'/Application/appType');?>">
				<i class="icon-double-angle-right"></i>
				应用类别
			</a>
		</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Application')][strtoupper('download')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Infoannounce">
			<a href="<?php echo U(GROUP_NAME.'/Application/download');?>">
				<i class="icon-double-angle-right"></i>
				下载管理
			</a>
		</li><?php endif; ?>


						</ul>
					</li><?php endif; ?>			
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Rbac')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="Rbacindex_Rbacrole_Rbacnode" <?php if(MODULE_NAME == 'Rbac'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-file"></i>
							<span>权限管理</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'Rbac'): ?>style="display: block;"<?php endif; ?>>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Rbac')][strtoupper('index')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Rbacindex">
								<a href="<?php echo U(GROUP_NAME.'/Rbac/index');?>">
									<i class="icon-double-angle-right"></i>
									管理员列表
								</a>
							</li><?php endif; ?>	
						
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Rbac')][strtoupper('role')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><!--<li url="Rbacrole">-->
						<!--		<a href="<?php echo U(GROUP_NAME.'/Rbac/role');?>">-->
						<!--			<i class="icon-double-angle-right"></i>-->
						<!--			角色列表-->
						<!--		</a>-->
						<!--	</li>--><?php endif; ?>	




<!--							
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('Rbac')][strtoupper('node')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="Rbacnode">
								<a href="<?php echo U(GROUP_NAME.'/Rbac/node');?>">
									<i class="icon-double-angle-right"></i>
									节点列表
								</a>
							</li><?php endif; ?>
-->				
				
						</ul>
						
					</li><?php endif; ?>	
		
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('System')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li sid="Logindex_BakbackUp_SystemcustomSetting"  <?php if(MODULE_NAME == 'System'): ?>class="open"<?php endif; ?>>
						<a href="#" class="dropdown-toggle">
							<i class="icon-text-width"></i>
							<span>系统设置</span>

							<b class="arrow icon-angle-down"></b>
						</a>

						<ul class="submenu" <?php if(MODULE_NAME == 'System'): ?>style="display: block;"<?php endif; ?>>
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('System')][strtoupper('backUp')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="BakbackUp">
								<a href="<?php echo U(GROUP_NAME.'/System/backUp');?>">
									<i class="icon-double-angle-right"></i>
									数据备份
								</a>
							</li><?php endif; ?>	
<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('System')][strtoupper('customSetting')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="SystemcustomSetting">
								<a href="<?php echo U(GROUP_NAME.'/System/customSetting');?>">
									<i class="icon-double-angle-right"></i>
									自定义配置
								</a>
							</li><?php endif; ?>
	<?php if((isset($acc[strtoupper(GROUP_NAME)][strtoupper('System')][strtoupper('systemlog')])) or (!empty($_SESSION[C('ADMIN_AUTH_KEY')]))): ?><li url="SystemcustomSetting">
			<a href="<?php echo U(GROUP_NAME.'/System/systemlog');?>">
				<i class="icon-double-angle-right"></i>
				系统日志
			</a>
		</li><?php endif; ?>

	</ul>
					</li><?php endif; ?>					
					
				</ul><!--/.nav-list-->

				<div id="sidebar-collapse">
					<i class="icon-double-angle-left"></i>
				</div>
			</div>

<script type="text/javascript">
	window.jQuery || document.write("<script src='__PUBLIC__/js/jquery-1.9.1.min.js">"+"<"+"/script>");
</script>
<script type="text/javascript">
	$(function() {
		var method = '<?php echo ($_SERVER['PATH_INFO']); ?>';
		var middle = method.split('/')[2];
		var end = method.split('/')[3];

		$('li[sid*='+ middle + end +']').addClass("active open");
		$('li[url*='+ middle + end +']').addClass("active");
	});
</script>

			<div id="main-content" class="clearfix">
				<div id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="icon-home"></i>
							<a href="#">Home</a>

							<span class="divider">
								<i class="icon-angle-right"></i>
							</span>
						</li>

						<li>
							<a href="#">信息交流</a>

							<span class="divider">
								<i class="icon-angle-right"></i>
							</span>
						</li>
					</ul><!--.breadcrumb-->
				</div>

				<div id="page-content" class="clearfix">
					<div class="page-header position-relative">
						<h1>
							编辑下载配置
						</h1>
					</div><!--/.page-header-->

					<div class="row-fluid">
						<!--PAGE CONTENT BEGINS HERE-->
							<form class="form-horizontal" name="addAnnounce"  enctype="multipart/form-data"  action="<?php echo U(GROUP_NAME.'/Application/editDownHandle');?>" method="post">
								<input type="hidden" name="id" value="<?php echo ($ann["id"]); ?>">
								<div class="control-group">
									<label class="control-label" for="key"> 标识</label>

									<div class="controls">
										<input type="text"  readonly  value="<?php echo ($ann["key"]); ?>" name="key" id="key" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="title"> 标题</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["title"]); ?>" name="title" id="title" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="size"> 文件大小</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["size"]); ?>" name="size" id="size" placeholder="" /><span>(单位：MB)</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="score"> 评分</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["score"]); ?>" name="score" id="score" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="person_num"> 评分人数</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["person_num"]); ?>" name="person_num" id="person_num" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="person_num_unit"> 评分人数单位</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["person_num_unit"]); ?>" name="person_num_unit" id="person_num_unit" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="install_num"> 安装次数</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["install_num"]); ?>" name="install_num" id="install_num" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="install_num_unit"> 安装次数单位</label>

									<div class="controls">
										<input type="text" value="<?php echo ($ann["install_num_unit"]); ?>" name="install_num_unit" id="install_num_unit" placeholder="" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="android_url"> 安卓地址</label>

									<div class="controls">
										<input type="text"  value="<?php echo ($ann["android_url"]); ?>" name="android_url" id="android_url" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="ios_url"> ios地址</label>

									<div class="controls">
										<input type="text"  value="<?php echo ($ann["ios_url"]); ?>" name="ios_url" id="ios_url" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="status"> 状态</label>

									<div class="controls">
										<select name="status" id="status">
											<option value="1" <?php if($ann['status'] == '1'): ?>selected<?php endif; ?> >开启</option>
											<option value="0" <?php if($ann['status'] == '0'): ?>selected<?php endif; ?>>关闭</option>

										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="image"> 缩略图</label>

									<div class="controls">
										<input type="file" name="image" value="<?php echo ($ann["logo_url"]); ?>"> 缩略图大小：300*250
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="content"> 简介</label>

									<div class="controls">
										<textarea name="content"  id="content" style="width:700px; height:300px"><?php echo ($ann["content"]); ?></textarea>
									</div>
								</div>
								<div class="form-actions">
									<button class="btn btn-info no-border" type="submit">
										<i class="icon-ok bigger-110"></i>
										保存编辑
									</button>
								</div>

							</form>
						<!--PAGE CONTENT ENDS HERE-->
					</div><!--/row-->
				</div><!--/#page-content-->

				<div id="ace-settings-container">
					<div class="btn btn-app btn-mini btn-warning" id="ace-settings-btn">
						<i class="icon-cog"></i>
					</div>

					<div id="ace-settings-box">
						<div>
							<div class="pull-left">
								<select id="skin-colorpicker" class="hidden">
									<option data-class="default" value="#438EB9">#438EB9</option>
									<option data-class="skin-1" value="#222A2D">#222A2D</option>
									<option data-class="skin-2" value="#C6487E">#C6487E</option>
									<option data-class="skin-3" value="#D0D0D0">#D0D0D0</option>
								</select>
							</div>
							<span>&nbsp; 选择样式</span>
						</div>

						<div>
							<input type="checkbox" class="ace-checkbox-2" id="ace-settings-header" />
							<label class="lbl" for="ace-settings-header"> Fixed Header</label>
						</div>

						<div>
							<input type="checkbox" class="ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
						</div>
					</div>
				</div><!--/#ace-settings-container-->
			</div><!--/#main-content-->
		</div><!--/.fluid-container#main-container-->

		<!--basic scripts-->

		<script src="__PUBLIC__/js/jquery-1.9.1.min.js"></script>
		<!--page specific plugin scripts-->

		<script src="__PUBLIC__/js/bootbox.min.js"></script>
		
		<script src="__PUBLIC__/js/bootstrap.min.js"></script>
			
		<!--bbc scripts-->
		<script src="__PUBLIC__/Js/jquery.validate.min.js"></script>
		<!--自定义JS-->
		<script type="text/javascript">
			$('form[name="addAnnounce"]').validate({
					//默认为lable
					errorElement : 'span',
					//失败时先移除成功的class
					validClass : 'success',
					//指定成功的样式
					success : function(span){
						span.addClass('success');
					},

					rules:{
                        key:{
                            required : true
                        },
                        title:{
							required : true
						},
                        size:{
							required : true
						},
                        score:{
                            required : true
                        },
                        person_num:{
                            required : true
                        },
                        person_num_unit:{
                            required : true
                        },
                        install_num:{
                            required : true
                        },
                        install_num_unit:{
                            required : true
                        },
                        ios_url:{
                            required : true
                        },
                        android_url:{
                            required : true
                        },
					},
					messages:{
                        key:{
                            required:'请填写唯一标识'
                        },
                        name:{
							required:'请填写标题'
						},
                        size:{
							required:'请填写文件大小'
						},
                        score:{
                            required:'请填写评分'
                        },
                        person_num:{
                            required:'请填写评分人数'
                        },
                        person_num_unit:{
                            required:'请填写评分人数单位'
                        },

                        install_num:{
                            required:'请填写安装次数'
                        },
                        install_num_unit:{
                            required:'请填写安装次数单位'
                        },
                        android_url:{
                            required:'请填写安卓地址'
                        },
                        ios_url:{
                            required:'请填写ios地址'
                        },
					}

				});
		</script>

		<script src="__PUBLIC__/js/bbc-elements.min.js"></script>
		<script src="__PUBLIC__/js/bbc.min.js"></script>
		<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					allowFileManager : true
				});
			});
		</script>
	</body>
</html>