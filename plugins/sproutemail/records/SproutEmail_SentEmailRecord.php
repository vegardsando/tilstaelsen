<?php
namespace Craft;

class SproutEmail_SentEmailRecord extends BaseRecord
{
	/**
	 * @return string
	 */
	public function getTableName()
	{
		return 'sproutemail_sentemail';
	}

	/**
	 * @return array
	 */
	public function defineAttributes()
	{
		return array(
			'title'        => array(AttributeType::Mixed, 'required' => false),
			'emailSubject' => array(AttributeType::Mixed, 'required' => false),
			'fromEmail'    => array(AttributeType::Mixed, 'required' => false),
			'fromName'     => array(AttributeType::Mixed, 'required' => false),
			'toEmail'      => array(AttributeType::Mixed, 'required' => false),
			'body'         => array(AttributeType::Mixed, 'required' => false),
			'htmlBody'     => array(AttributeType::Mixed, 'required' => false),
			'info'         => array(AttributeType::Mixed, 'required' => false),
			'status'       => array(AttributeType::String, 'required' => false, 'default' => 'sent')
		);
	}

	/**
	 * @return array
	 */
	public function defineRelations()
	{
		return array(
			'element' => array(
				static::BELONGS_TO,
				'ElementRecord',
				'id',
				'required' => true,
				'onDelete' => static::CASCADE
			)
		);
	}

	public function defineIndexes()
	{
		return array(
			array('columns' => array('id')),
		);
	}
}
