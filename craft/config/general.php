<?php

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

 /* Denne kan aktiveres når rett domene er oppe og kjører. VROOOOM!
 if (strpos($_SERVER['SERVER_NAME'], 'tornado-node.net') !== false && CRAFT_ENVIRONMENT == 'PROD') {
	$query = str_replace('p=', '', $_SERVER['QUERY_STRING']);
	$query = preg_replace('/&/', '?', $query, 1);

	header("Location: http://what ever the fuck you want.com/".$query);
	die();
}
*/
 // Ensure our urls have the right scheme
define('URI_SCHEME', ( isset($_SERVER['HTTPS'] ) ) ? "https://" : "http://" );

// The site url
define('SITE_URL', URI_SCHEME . $_SERVER['SERVER_NAME'] . '/');

// The CDN url
// $array = explode(".", $_SERVER['SERVER_NAME'].'/');
// $cdn =  (array_key_exists(count($array) - 2, $array) ? $array[count($array) - 2] : "").".".$array[count($array) - 1];
//
// define('CDN_URL', URI_SCHEME .'cdn.'.$cdn);

/* For mer snedige configs
	http://straightupcraft.com/articles/custom-multi-environment-config-and-examples-of-how-to-customize-each-environment
*/

$customConfig = array(
	'*' => array(

		'maxUploadFileSize' => 67108864,

        // We can use these variables in the URL and Path settings within
        // the Craft Control Panel.  i.e. siteUrl => {siteUrl}, basePath => {basePath}
        'environmentVariables' => array(
            'siteUrl'  => SITE_URL,
            'basePath' => BASEPATH,
			'cdnUrl' => SITE_URL,
        ),

        'enableTemplateCaching' => false,
		'siteUrl' => SITE_URL,
        'cdnUrl' => SITE_URL,

		'defaultWeekStartDay' => 1,

		'disableDevmodeMinifying' => true,

		'usePathInfo' => true,
		//'addTrailingSlashesToUrls' => true,
		'enableCsrfProtection' => true,

        // Create a custom variable that we can use for an environment conditional
        // We set the environment in index.php: live, dev, or local
        // This setting assumes we set the environment name in our index.php file
        // {% if craft.config.env == 'live' %} ... {% endif %}
        'env' => CRAFT_ENVIRONMENT,

		//Whether Craft should convert any non-ASCII characters in uploaded file names to ASCII.
		'convertFilenamesToAscii' => true,

        /* Whether Craft should omit the script filename currently being used to access Craft (e.g. index.php) when generating URLs.
	       When set to 'auto', Craft will do its best to determine whether the server is set up to support index.php redirects, and cache the test�s results for 24 hours. */
        'omitScriptNameInUrls' 			=> true,

         /* Configures Craft to generate new image transforms right when getUrl() is called, rather than when the browser first requests the image. */

        'generateTransformsBeforePageLoad' => true,
		// The path prefix to HTTP error code templates, like 404.html.
		'errorTemplatePrefix' => "_errors/",

        // Triggers
        // If you wish to access the control panel via a different URL
        // or change your page trigger for pagination, you can do so here.
        // 'cpTrigger'       				=> 'admin',
        // 'pageTrigger'     				=> 'p',

        // User account related paths
        // Depending on your user needs, you may want to adjust several
        // of the available user settings to customize your users workflow
        // for logging in, changing a password, or being activated
        //'loginPath'                   => 'members',
        //'logoutPath'                  => 'logout',
        //'setPasswordPath'             => 'members/set-password',
        //'setPasswordSuccessPath'      => 'members',
        //'activateAccountSuccessPath'  => 'members?activate=success',
        //'activateAccountFailurePath'  => 'members?activate=fail',
    ),
	'DEV' => array(
		/*LOCAL er samme som denne, definert under */

		// Give us more useful error messages
	   'devMode'    => true,

	   // Have Craft send ALL emails to a single address
	   'testToEmailAddress'			=> 'dev@mustasj.no',

	   // Some settings helpful for debugging
	   'phpMaxMemoryLimit'          	=> '256M',
	   'backupDbOnUpdate'           	=> true,
	   'translationDebugOutput'     	=> false,
	   'useCompressedJs'            	=> true,
	   'cacheDuration'              	=> 'P1D',

	   // Make member login settings nice and trusting
	   // by allowing a user to stay logged in for 101 years
	   // and relaxing various other related settings
	   // http://www.php.net/manual/en/dateinterval.construct.php
	   'userSessionDuration'           => 'P101Y',
	   'rememberedUserSessionDuration' => 'P101Y',
	   'rememberUsernameDuration'      => 'P101Y',
	   'invalidLoginWindowDuration'    => 'P101Y',
	   'cooldownDuration'              => 'PT1S',
	   'maxInvalidLogins'              => 101,
	),
	'PROD' => array(
		// Setting allowAutoUpdates to false will disable the
        // ability to use the one-click update feature.  This might
        // be useful if you are managing a git workflow and want to
        // ensure that updates happen in your repository first.

		//'isSystemOn' => false,
		'enableTemplateCaching' => true,
        'allowAutoUpdates' => false
	)
);
$customConfig['LOCAL'] = $customConfig['DEV'];

// If a local config file exists, merge any local config settings
if (is_array($customLocalConfig = @include(CRAFT_CONFIG_PATH . 'local/general.php')))
{
	$customGlobalConfig = array_merge($customConfig['*'], $customLocalConfig);
	$customConfig = $customGlobalConfig;
}
return $customConfig;
