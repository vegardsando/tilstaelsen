<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m160804_000003_sproutEmail_migrateNotificationEmails extends BaseMigration
{
	/**
	 * Any migration code in here is wrapped inside of a transaction.
	 *
	 * @return bool
	 */
	public function safeUp()
	{
		SproutEmailPlugin::log('Moving all notifications to the sproutemail_notificationemails table');

		if (!craft()->db->tableExists('sproutemail_campaigns') ||
			!craft()->db->tableExists('sproutemail_campaigns_notifications') ||
			!craft()->db->tableExists('sproutemail_campaigns_entries')
		)
		{
			return;
		}

		$entries = craft()->db->createCommand()
			->select('*')
			->from('sproutemail_campaigns setting')
			->join('sproutemail_campaigns_notifications notification', 'setting.id = notification.campaignId')
			->join('sproutemail_campaigns_entries email', 'setting.id = email.campaignId')
			->where(array('type' => 'notification'))
			->queryAll();

		$oldNotifications = array();

		if (!empty($entries))
		{
			foreach ($entries as $key => $entry)
			{
				$oldNotifications[$key] = $entry;
			}
		}

		if (!empty($oldNotifications))
		{
			foreach ($oldNotifications as $oldNotification)
			{
				$newNotification = array(
					'id'                    => $oldNotification['id'],
					'name'                  => $oldNotification['name'],
					'template'              => $oldNotification['template'],
					'eventId'               => $oldNotification['eventId'],
					'options'               => $oldNotification['options'],
					'subjectLine'           => $oldNotification['subjectLine'],
					'recipients'            => $oldNotification['recipients'],
					'fromName'              => $oldNotification['fromName'],
					'fromEmail'             => $oldNotification['fromEmail'],
					'replyToEmail'          => $oldNotification['replyToEmail'],
					'sent'                  => $oldNotification['sent'],
					'fieldLayoutId'         => $oldNotification['fieldLayoutId'],
					'enableFileAttachments' => $oldNotification['enableFileAttachments'],
				);

				if (craft()->db->tableExists('sproutemail_notificationemails'))
				{
					$notificationEmail = craft()->db->createCommand()
						->select('id')
						->from('sproutemail_notificationemails')
						->where(array('id' => $oldNotification['id']))
						->queryAll();

					if (!empty($notificationEmail))
					{
						continue;
					}

					craft()->db->createCommand()->insert('sproutemail_notificationemails', $newNotification);
				}

				craft()->db->createCommand()->update('elements', array(
					'type' => 'SproutEmail_NotificationEmail'
				),
					'id= :id', array(':id' => $oldNotification['id'])
				);

				craft()->db->createCommand()->update('fieldlayouts', array(
					'type' => 'SproutEmail_NotificationEmail'
				),
					'id= :id', array(':id' => $oldNotification['fieldLayoutId'])
				);

				// Remove old notifications data
				craft()->db->createCommand()->delete('sproutemail_campaigns_entries', array(
					'id' => $oldNotification['id']
				));

				craft()->db->createCommand()->delete('sproutemail_campaigns', array(
					'type' => 'notification'
				));

				// Grab and resave the Element to Update the URI on the Element table
				$criteria                 = craft()->elements->getCriteria('SproutEmail_NotificationEmail');
				$criteria->id             = $newNotification['id'];
				$notificationEmailElement = $criteria->first();

				if ($notificationEmailElement)
				{
					craft()->elements->updateElementSlugAndUri($notificationEmailElement, false, false);
				}
			}
		}

		SproutEmailPlugin::log('Finished moving all notifications to the sproutemail_notificationemails table');

		return true;
	}
}
