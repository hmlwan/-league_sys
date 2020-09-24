<?php  
	/**
	 * 应用与应用类别的关系模型
	 */
	Class AppRelationModel extends RelationModel{
		//定义主表名称
		protected $tableName = 'application';

		//定义关联关系
		protected $_link = array(
			'application_type'=>array(
				'mapping_type'=>BELONGS_TO,
				'foreign_key'=>'type_id',
				'mapping_order'=>'sort desc'
				),
			
			);

	}
?>