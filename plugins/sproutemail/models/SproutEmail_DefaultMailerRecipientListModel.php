<?php
namespace Craft;

/**
 * Class SproutEmail_DefaultMailerRecipientListModel
 *
 * @package Craft
 *
 * @property int                                       $id
 * @property string                                    $name
 * @property string                                    $handle
 * @property bool                                      $dynamic Whether or not the list was created dynamically
 * @property SproutEmail_DefaultMailerRecipientModel[] $recipients
 */
class SproutEmail_DefaultMailerRecipientListModel extends BaseModel
{
	public function defineAttributes()
	{
		return array(
			'id'         => AttributeType::Number,
			'name'       => array(AttributeType::String, 'required' => true),
			'handle'     => array(AttributeType::String, 'required' => false),
			'dynamic'    => array(
				AttributeType::Bool,
				'default' => 0,
				'column'  => ColumnType::TinyInt
			),
			'recipients' => array(AttributeType::Mixed, 'required' => false),
		);
	}
}
