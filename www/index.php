<?php

$root = '';
// Path to your craft/ folder
$craftPath = $root.'../craft';

define('SERVER_NAME', $_SERVER['SERVER_NAME']);
//define('CRAFT_LOCALE', 'no');

switch(true){
	case (strstr(SERVER_NAME, '.loc')):
	    define('CRAFT_ENVIRONMENT', 'LOCAL');
		break;
	case (strstr(SERVER_NAME, '.dev')):
	    define('CRAFT_ENVIRONMENT', 'DEV');
		break;
	// case (strpos(SERVER_NAME, 'mustasj.no') !== false):
	//     define('CRAFT_ENVIRONMENT', 'STAGE');
	// 	break;
	default:
		define('CRAFT_ENVIRONMENT', 'PROD');
		break;
}

// Move plugins path to right above web root
define('CRAFT_PLUGINS_PATH', realpath(dirname(__FILE__) . "/" .$root . "../plugins").'/');
// Move templates path to right above web root
define('CRAFT_TEMPLATES_PATH', realpath(dirname(__FILE__) . "/" .$root . "/../templates").'/');
// Get right basepath to public root
define('BASEPATH', realpath(dirname(__FILE__)).'/'.$root);

// Do not edit below this line
$path = rtrim($craftPath, '/').'/app/index.php';

if (!is_file($path))
{
	if (function_exists('http_response_code'))
	{
		http_response_code(503);
	}

	exit('Could not find your craft/ folder. Please ensure that <strong><code>$craftPath</code></strong> is set correctly in '.__FILE__);
}

require_once $path;
