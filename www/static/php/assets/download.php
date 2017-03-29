<?php include('login.php');

global $loggedIn;

if (!$loggedIn) {
	header( 'Location: ../' ) ;
	die();
}else{
	echo '<meta charset="UTF-8">';
	function strpos_arr($haystack, $needle) {
	    if(!is_array($needle)) $needle = array($needle);
	    foreach($needle as $what) {
	        if(($pos = strpos($haystack, $what))!==false) return $pos;
	    }
	    return false;
	}

	function rmdir_recursive($dir) {
		if(is_dir($dir)){
		    foreach(scandir($dir) as $file) {
		        if ('.' === $file || '..' === $file) continue;
		        if (is_dir("$dir/$file")) rmdir_recursive("$dir/$file");
		        else unlink("$dir/$file");
		    }
		    rmdir($dir);
	    }
	    mkdir($dir);
	}

	function Zip($source, $destination, $exlude = false)
	{

	    if (!extension_loaded('zip') || !file_exists($source)) {
	        return false;
	    }

	    $zip = new ZipArchive();
	    if (!$zip->open($destination, ZIPARCHIVE::CREATE)) {
	        return false;
	    }

	    $source = str_replace('\\', '/', realpath($source));

	    if (is_dir($source) === true)
	    {
	        $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($source), RecursiveIteratorIterator::SELF_FIRST);

	        foreach ($files as $file)
	        {
	            $file = str_replace('\\', '/', $file);

	            // Ignore "." and ".." folders
	            if( in_array(substr($file, strrpos($file, '/')+1), array('.','..')) )
	                continue;

	            $file = realpath($file);

	            if($exlude != false){
			        if (is_array($exlude)) {
				          if(strpos_arr($file, $exlude))
						  continue;
				     }else {
				          if(strpos($file, $exlude) !== false)
						  continue;
				     }
	            }


	            if (is_dir($file) === true)
	            {
	                $zip->addEmptyDir(str_replace($source . '/', '', $file . '/'));

	            }
	            else if (is_file($file) === true)
	            {
	            	if( in_array(substr($file, strrpos($file, '/')+1), array('script.zip','.DS_Store')) )
	                continue;
	                $zip->addFromString(str_replace($source . '/', '', $file), file_get_contents($file));
	            }

	            if(isset($_GET['debug'])){
		            echo $file.'<br/>';
	            }
	        }


	    }
	    else if (is_file($source) === true)
	    {
	        $zip->addFromString(basename($source), file_get_contents($source));
	    }

	    return $zip->close();
	}

	echo 'Starting to zip!<br/>';
	echo '----------------------------------<br/>';
	rmdir_recursive('./zips');

	if(Zip('../../../dynamic/', './zips/dynamic.zip', array('/dynamic/imager/'))){
		echo 'dynamic.zip ble laget ';
		echo '<a href="zips/dynamic.zip">Last ned</a><br/>';

		if(Zip('../../script/', '../../script.zip')){
			echo '----------------------------------<br/>';
			echo 'script.zip ble laget ';
			echo '<a href="../../script.zip">Last ned</a><br/>';
		}
	} else {
		echo 'Det skjedde en feil';
	}

}
?>
