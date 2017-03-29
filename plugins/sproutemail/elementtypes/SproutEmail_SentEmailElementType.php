<?php
namespace Craft;

class SproutEmail_SentEmailElementType extends BaseElementType
{
	/**
	 * @return string
	 */
	public function getName()
	{
		return Craft::t('Sprout Sent Email');
	}

	/**
	 * @return bool
	 */
	public function hasTitles()
	{
		return true;
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
	 * @inheritDoc IElementType::hasStatuses()
	 *
	 * @return bool
	 */
	public function hasStatuses()
	{
		return true;
	}

	/**
	 * @return array
	 */
	public function getStatuses()
	{
		return array(
			SproutEmail_SentEmailModel::SENT   => Craft::t('Sent'),
			SproutEmail_SentEmailModel::FAILED => Craft::t('Failed')
		);
	}

	/**
	 * @inheritDoc IElementType::getElementQueryStatusCondition()
	 *
	 * @param DbCommand $query
	 * @param string    $status
	 *
	 * @return array|false|string|void
	 */
	public function getElementQueryStatusCondition(DbCommand $query, $status)
	{
		switch ($status)
		{
			case SproutEmail_SentEmailModel::SENT:
			{
				$query->andWhere("sentemail.status IS NULL OR sentemail.status != 'failed'");

				break;
			}
			case SproutEmail_SentEmailModel::FAILED:
			{
				//$query->andWhere('elements.enabled = 1');
				//$query->andWhere('campaigns.template IS NULL OR campaigns.mailer IS NULL');
				$query->andWhere("sentemail.status = 'failed'");

				break;
			}
		}
	}

	/**
	 * @param null $context
	 *
	 * @return array
	 */
	public function getSources($context = null)
	{

		$sources = array(
			'*' => array(
				'label' => Craft::t('All Sent Emails'),
			),
		);

		return $sources;
	}

	/**
	 * Returns the attributes that can be selected as table columns
	 *
	 * @return array
	 */
	public function defineAvailableTableAttributes()
	{
		$attributes = array(
			'emailSubject'           => array('label' => Craft::t('Subject')),
			'fromEmail'              => array('label' => Craft::t('From Email')),
			'campaignNotificationId' => array('label' => Craft::t('Notification Type')),
			'dateCreated'            => array('label' => Craft::t('Date Created')),
			'dateUpdated'            => array('label' => Craft::t('Date Updated'))
		);

		return $attributes;
	}

	/**
	 * @return array
	 */
	public function defineSortableAttributes()
	{
		return array(
			'emailSubject' => Craft::t('Subject'),
			'dateCreated'  => Craft::t('Date Sent')
		);
	}

	/**
	 * Returns default table columns for table views
	 *
	 * @return array
	 */
	public function getDefaultTableAttributes($source = null)
	{
		$attributes = array();

		$attributes[] = 'emailSubject';
		$attributes[] = 'fromEmail';
		$attributes[] = 'toEmail';
		$attributes[] = 'dateCreated';
		$attributes[] = 'dateUpdated';

		return $attributes;
	}

	/**
	 * Defines any custom element criteria attributes for this element type.
	 *
	 * @return array
	 */
	public function defineCriteriaAttributes()
	{
		return array(
			'emailSubject' => AttributeType::String,
			'fromEmail'    => AttributeType::String,
			'toEmail'      => AttributeType::String,
			'dateCreated'  => AttributeType::Mixed
		);
	}

	/**
	 * @param BaseElementModel $element
	 * @param string           $attribute
	 *
	 * @return mixed|string
	 */
	public function getTableAttributeHtml(BaseElementModel $element, $attribute)
	{

		switch ($attribute)
		{

			default:
			{
				return parent::getTableAttributeHtml($element, $attribute);
			}
		}
	}

	/**
	 * @param ElementCriteriaModel $criteria
	 * @param array                $disabledElementIds
	 * @param array                $viewState
	 * @param null|string          $sourceKey
	 * @param null|string          $context
	 * @param bool                 $includeContainer
	 * @param bool                 $showCheckboxes
	 *
	 * @return string
	 */
	public function getIndexHtml($criteria, $disabledElementIds, $viewState, $sourceKey, $context, $includeContainer, $showCheckboxes)
	{
		$order = isset($viewState['order']) ? $viewState['order'] : 'dateCreated';
		$sort  = isset($viewState['sort']) ? $viewState['sort'] : 'desc';

		$criteria->limit = null;
		$criteria->order = sprintf('%s %s', $order, $sort);

		// Add this to prevent search error
		if (!empty($viewState['order']) && $viewState['order'] == 'score')
		{
			$criteria->order = 'score';
		}

		craft()->templates->includeJsResource('sproutemail/js/sproutmodal.js');
		craft()->templates->includeJs('var sproutModalInstance = new SproutModal(); sproutModalInstance.init();');

		return craft()->templates->render(
			'sproutemail/_partials/sentemails/entryindex', array(
				'context'            => $context,
				'elementType'        => new ElementTypeVariable($this),
				'disabledElementIds' => $disabledElementIds,
				'elements'           => $criteria->find()
			)
		);
	}

	/**
	 * Modifies an element query targeting elements of this type.
	 *
	 * @param DbCommand            $query
	 * @param ElementCriteriaModel $criteria
	 *
	 * @return mixed
	 */
	public function modifyElementsQuery(DbCommand $query, ElementCriteriaModel $criteria)
	{
		// join with the table
		$query->addSelect('sentemail.*, sentemail.dateCreated')
			->join('sproutemail_sentemail sentemail', 'sentemail.id = elements.id');

		if ($criteria->order)
		{
			// Trying to order by date creates ambiguity errors
			// Let's make sure mysql knows what we want to sort by
			if (stripos($criteria->order, 'elements.') === false)
			{
				$criteria->order = str_replace('dateCreated', 'sentemail.dateCreated', $criteria->order);
				$criteria->order = str_replace('dateUpdated', 'sentemail.dateUpdated', $criteria->order);
			}
		}

		if ($criteria->toEmail)
		{
			$query->andWhere(DbHelper::parseParam('sentemail.toEmail', $criteria->toEmail, $query->params));
		}
	}

	public function defineSearchableAttributes()
	{
		return array('title', 'toEmail');
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
		$deleteAction = craft()->elements->getAction('SproutEmail_SentEmailDelete');

		$deleteAction->setParams(array(
			'confirmationMessage' => Craft::t('Are you sure you want to delete the selected emails?'),
			'successMessage'      => Craft::t('Emails deleted.'),
		));

		return array($deleteAction);
	}

	/**
	 * Populates an element model based on a query result.
	 *
	 * @param array $row
	 *
	 * @return array
	 */
	public function populateElementModel($row)
	{
		return SproutEmail_SentEmailModel::populateModel($row);
	}
}
