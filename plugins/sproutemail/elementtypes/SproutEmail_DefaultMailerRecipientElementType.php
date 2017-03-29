<?php
namespace Craft;

class SproutEmail_DefaultMailerRecipientElementType extends BaseElementType
{
	/**
	 * @return string
	 */
	public function getName()
	{
		return Craft::t('Sprout Email Recipient');
	}

	/**
	 * @return bool
	 */
	public function hasContent()
	{
		return false;
	}

	/**
	 * @return bool
	 */
	public function isLocalized()
	{
		return false;
	}

	/**
	 * @return bool
	 */
	public function hasTitles()
	{
		return false;
	}

	/**
	 * @param string|null $context
	 *
	 * @return array|false
	 */
	public function getSources($context = null)
	{
		$sources = array(
			'*' => array(
				'label' => Craft::t('All Recipients'),
			),
		);

		$recipientLists = sproutEmailDefaultMailer()->getRecipientLists();

		if ($recipientLists)
		{
			foreach ($recipientLists as $recipientList)
			{
				$key = 'recipientlist:' . $recipientList->id;

				$sources[$key] = array(
					'label'    => Craft::t($recipientList->name) . " (" . count($recipientList->recipients) . ")",
					'criteria' => array('recipientListId' => $recipientList->id),
				);
			}
		}

		return $sources;
	}

	/**
	 * @inheritDoc IElementType::getAvailableActions()
	 *
	 * @param string|null $source
	 *
	 * @return array|null
	 */
	public function getAvailableActions($source = null)
	{
		$exportRecipientAction = craft()->elements->getAction('SproutEmail_ExportRecipients');

		$exportRecipientAction->setParams(
			array(
				'confirmationMessage' => Craft::t('Are you sure you want to export all recipients?'),
				'successMessage'      => Craft::t('Generating the data we need for the export...')
			)
		);

		return array($exportRecipientAction);
	}

	/**
	 * @param string|null $source
	 *
	 * @return array
	 */
	public function defineTableAttributes($source = null)
	{
		return array(
			'email'     => Craft::t('Email'),
			'firstName' => Craft::t('First Name'),
			'lastName'  => Craft::t('Last Name'),
		);
	}

	/**
	 * @param BaseElementModel $element
	 * @param string           $attribute
	 *
	 * @return string
	 */
	public function getTableAttributeHtml(BaseElementModel $element, $attribute)
	{
		switch ($attribute)
		{
			default:
				return parent::getTableAttributeHtml($element, $attribute);
				break;
		}
	}

	/**
	 * @return array
	 */
	public function defineCriteriaAttributes()
	{
		return array(
			'id'              => AttributeType::Number,
			'email'           => AttributeType::Email,
			'firstName'       => AttributeType::String,
			'lastName'        => AttributeType::String,
			'recipientListId' => AttributeType::Number,
		);
	}

	public function defineSearchableAttributes()
	{
		return array('email', 'firstName', 'lastName');
	}

	public function modifyElementsQuery(DbCommand $query, ElementCriteriaModel $criteria)
	{
		$query
			->addSelect('recipients.*')
			->join('sproutemail_defaultmailer_recipients recipients', 'recipients.id = elements.id');

		if ($criteria->id)
		{
			$query->andWhere(DbHelper::parseParam('recipients.id', $criteria->id, $query->params));
		}

		if ($criteria->recipientListId)
		{
			$query->join('sproutemail_defaultmailer_recipientlistrecipients relationships', 'relationships.recipientId = recipients.id');
			$query->andWhere(DbHelper::parseParam('relationships.recipientListId', $criteria->recipientListId, $query->params));
		}
	}

	public function populateElementModel($row)
	{
		return SproutEmail_DefaultMailerRecipientModel::populateModel($row);
	}
}
