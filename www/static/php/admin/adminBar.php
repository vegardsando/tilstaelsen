<?php
$adminBar['bar'] = '';
$root = substr(__FILE__, 0, -strlen($_SERVER['SCRIPT_NAME']));

include_once(dirname(__FILE__) . '/functions.php');

// Read .mustasj.json


if (file_exists($root.'/../.mustasj.json')) {

    $mustasjconfig = file_get_contents($root.'/../.mustasj.json');
    $mustasjconfig_json = json_decode($mustasjconfig, true);

    if (array_key_exists('deployhqProjecturi', $mustasjconfig_json)) {
        $id = $mustasjconfig_json['deployhqProjecturi'];
        if($id != false) {
            $adminBar['bar'] .= '<button onclick="getDeployRSS(\''.$id.'\')" title="DeployHQ"><span id="deployicon"></span></button>';
    	}
    }
}

$branch = getGitBranch($root);
if ($branch !== null){
	$difference = strtolower ($branch) != 'master' ? 'diff' : '';
	$adminBar['bar'] .= '<span class="git '.$difference.'">'.$branch.'</span>'; //show it on the page
}

if (isset($_GET['debug'])) {
    echo '<pre>';
    print_r($mustasjconfig_json);
    echo '</pre>';
} else {
    print json_encode($adminBar, JSON_PRETTY_PRINT);
}
