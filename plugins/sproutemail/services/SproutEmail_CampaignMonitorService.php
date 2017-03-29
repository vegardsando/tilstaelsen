<?php
namespace Craft;

use CS_REST_Campaigns;
use CS_REST_Clients;
use CS_REST_Lists;
use CS_REST_Subscribers;

/**
 * Class SproutEmailCampaignMonitorService
 *
 * @package Craft
 */
class SproutEmail_CampaignMonitorService extends BaseApplicationComponent
{
	/**
	 * @var Model|null
	 */
	protected $settings;

	public function init()
	{
		require_once dirname(__FILE__) . '/../vendor/autoload.php';
	}

	/**
	 * @param $settings
	 *
	 * @throws Exception
	 */
	public function setSettings(Model $settings)
	{
		if (is_object($settings) && method_exists($settings, 'validate'))
		{
			if (!$settings->validate())
			{
				throw new Exception(Craft::t('Please configure your API settings for Campaign Monitor.'));
			}
		}

		$this->settings = $settings;
	}

	/**
	 * @throws \Exception
	 *
	 * @return array
	 */
	public function getRecipientLists()
	{
		$lists = array();

		try
		{
			$client = new CS_REST_Clients($this->settings['clientId'], $this->getPostParams());
			$result = $client->get_lists();

			if ($result->was_successful())
			{
				return $result->response;
			}
			else
			{
				sproutEmail()->error('Unable to get lists', array('result' => $result));
			}
		}
		catch (\Exception $e)
		{
			sproutEmail()->error($e->getMessage());
		}

		return $lists;
	}

	/**
	 * @param SproutEmail_CampaignEmailModel $campaignEmail
	 * @param SproutEmail_CampaignTypeModel  $campaignType
	 *
	 * @return array
	 * @throws \Exception
	 */
	public function sendCampaignEmail(SproutEmail_CampaignEmailModel $campaignEmail, SproutEmail_CampaignTypeModel $campaignType)
	{
		$urls = $this->getCampaignEmailUrls($campaignEmail->id, $campaignType->template);

		$lists          = SproutEmail_RecipientListRelationsRecord::model()->findAllByAttributes(array(
			'emailId' => $campaignEmail->id
		));

		$recipientLists = array();
		$toEmails       = array();

		foreach ($lists as $list)
		{
			array_push($recipientLists, $list->list);
			$toEmails[] = $this->getListLabel($list->list);
		}

		$params = array(
			'email'     => $campaignEmail,
			'campaign'  => $campaignType,
			'recipient' => array(
				'firstName' => 'First',
				'lastName'  => 'Last',
				'email'     => 'user@domain.com'
			),

			// @deprecate - in favor of `email` in v3
			'entry'     => $campaignEmail
		);

		$content = array(
			'html' => sproutEmail()->renderSiteTemplateIfExists($campaignType->template, $params),
			'text' => sproutEmail()->renderSiteTemplateIfExists($campaignType->template . '.txt', $params),
		);

		try
		{
			$auth   = $this->getPostParams();
			$params = array(
				'Subject'   => $campaignEmail->subjectLine,
				'Name'      => $campaignType->name . ': ' . $campaignEmail->subjectLine,
				'FromName'  => $campaignEmail->fromName,
				'FromEmail' => $campaignEmail->fromEmail,
				'ReplyTo'   => $campaignEmail->replyToEmail,
				'HtmlUrl'   => $campaignEmail->getUrl(),
				'TextUrl'   => $campaignEmail->getUrl() . '?type=text',
				'ListIDs'   => $recipientLists
			);

			// Set up API call to create a draft campaign and assign the response to $response
			$draftCampaign = new CS_REST_Campaigns(null, $auth);
			$response      = $draftCampaign->create($this->settings['clientId'], $params);

			$email = new EmailModel();

			$email->subject   = $campaignEmail->subjectLine;
			$email->fromName  = $campaignEmail->fromName;
			$email->fromEmail = $campaignEmail->fromEmail;
			$email->body      = $content['text'];
			$email->htmlBody  = $content['html'];

			if (!empty($toEmails))
			{
				$email->toEmail = implode(', ', $toEmails);
			}

			// Conditional return for success/fail response from Campaign Monitor
			if (!$response->was_successful())
			{
				sproutEmail()->error('Error creating campaign in Campaign Monitor: ' . $response->http_status_code . ' - ' . $response->response->Message);

				throw new Exception(Craft::t('{code}: {msg}', array('code' => $response->http_status_code, 'msg' => $response->response->Message)));
			}
			else
			{
				sproutEmail()->info('Successfully created campaign in Campaign Monitor with ID: ' . $response->response);

				$this->sendEmailViaService($campaignEmail, $response->response, $auth);

				return array('id' => $response->response, 'emailModel' => $email);
			}
		}
		catch (\Exception $e)
		{
			sproutEmail()->error('Error creating campaign in Campaign Monitor: ' . $e->getMessage());

			throw $e;
		}
	}

	/*
	 * @return true|false according to the success of the request
	 */
	public function sendEmailViaService(SproutEmail_CampaignEmailModel $campaignEmail, $campaignTypeId, $auth)
	{
		// Access the newly created draft campaign
		$campaignToSend = new CS_REST_Campaigns($campaignTypeId, $auth);

		// Try to send the campaign 
		try
		{
			$response = $campaignToSend->send(
				array(
					'ConfirmationEmail' => $campaignEmail->replyToEmail,
					'SendDate'          => 'immediately'
				)
			);

			if (!$response->was_successful())
			{
				sproutEmail()->error('Error sending campaign through Campaign Monitor: ' . $response->http_status_code . ' - ' . $response->response->Message);

				return false;
			}
			else
			{
				sproutEmail()->info('Successfully sent campaign through Campaign Monitor with ID: ' . $campaignTypeId);

				return true;
			}
		}
		catch (\Exception $e)
		{
			sproutEmail()->error('Error sending campaign through Campaign Monitor: ' . $e->getMessage());

			throw $e;
		}
	}

	/**
	 * Adds or updates the user to a subscriber list
	 *
	 * @param null      $listId
	 * @param           $apiKey
	 * @param BaseModel $subscriber
	 * @param bool      $update
	 *
	 * @return array
	 * @throws Exception
	 */
	public function addOrUpdateSubscriber($listId = null, $apiKey, BaseModel $subscriber, $update = false)
	{
		/*
		 * @todo make sure $apiKey is coming from settings, not passed in as an argument
		 */
		if (is_null($listId))
		{
			throw new Exception(Craft::t('List ID cannot be null.'));
		}
		if (is_null($apiKey))
		{
			throw new Exception(Craft::t('API Key cannot be null.'));
		}

		$csRestSubscribers      = new CS_REST_Subscribers($listId, $apiKey);
		$subscriberCustomFields = array();

		/*
		 * Properties of the model passed in to this function will be
		 * parsed from "camelCase" to "Normal Case" for the field's
		 * Campaign Monitor key
		 *
		 * i.e. (BaseModel)$subscriber->postalCode should have a matching
		 * custom field in Campaign Monitor of "Postal Code"
		 */
		$subscriber->prefix = $subscriber->prefix->value;
		foreach ($subscriber->getAttributes() as $key => $value)
		{
			array_push($subscriberCustomFields, array(
				'Key'   => ucfirst($this->parseCamelCase($key)),
				'Value' => $value
			));
		}

		$subscriber = array(
			'EmailAddress'                           => $subscriber->email,
			'Name'                                   => $subscriber->firstName . ' ' . $subscriber->lastName,
			'CustomFields'                           => $subscriberCustomFields,
			'Resubscribe'                            => true,
			'RestartSubscriptionBasedAutoresponders' => true,
		);

		if ($update)
		{
			$csRestSubscribers->update($subscriber['EmailAddress'], $subscriber);
		}
		else
		{
			$csRestSubscribers->add($subscriber);
		}

		return $this->tryJsonResponse($csRestSubscribers);
	}

	/**
	 * Converts "camelCase" to Normal Case
	 *
	 * @param $string
	 *
	 * @return string
	 */
	function parseCamelCase($string)
	{
		return preg_replace('/(?!^)[A-Z]{2,}(?=[A-Z][a-z])|[A-Z][a-z]|[0-9]{1,}/', ' $0', $string);
	}

	/*
	 * @return JSON containing recipient list stats
	 */
	public function getListStats($listId)
	{
		// Get stats belonging to a list with the given ID
		$list     = new CS_REST_Lists($listId, $this->getPostParams());
		$response = $list->get_stats()->response;

		return $this->tryJsonResponse($response);
	}

	/*
	 * @return JSON containing recipient list details
	 */
	public function getDetails($listId)
	{
		// Get stats belonging to a list with the given ID
		$list     = new CS_REST_Lists($listId, $this->getPostParams());
		$response = $list->get()->response;

		return $this->tryJsonResponse($response);
	}

	public function getPostParams(array $extra = array())
	{
		$params = array(
			'api_key' => $this->settings['apiKey']
		);

		return array_merge($params, $extra);
	}

	private function tryJsonResponse($response)
	{
		try
		{
			$items = $response;

			return $items;
		}
		catch (\Exception $e)
		{
			return array();
		}
	}

	public function getCampaignEmailUrls($emailId, $template)
	{
		// @todo: make sure these URLs are getting assigned
		// to a live, outside accessible URL
		// Assign html/text URLs for Campaign Monitor to scrape
		$urls = array(
			'html' => craft()->siteUrl . 'index.php/admin/actions/sproutEmail/campaignEmails/shareCampaignEmail?emailId=' . $emailId . '&template=html'
		);

		// Determine if a text template exists
		$urls['hasText'] = sproutEmail()->doesSiteTemplateExist($template . '.txt');
		if ($urls['hasText'])
		{
			$urls['text'] = craft()->siteUrl . 'index.php/admin/actions/sproutEmail/campaignEmails/shareCampaignEmail?emailId=' . $emailId . '&template=text';
		}

		return $urls;
	}

	public function getListLabel($id)
	{
		$details = $this->getDetails($id);

		$stats = $this->getListStats($id)->TotalActiveSubscribers;

		return sprintf('%s (%d)', $details->Title, $stats);
	}
}
