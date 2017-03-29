<?php

function getGitBranch($root) {
		/**
		* @filename: currentgitbranch.php
		* @usage: Include this file after the '<body>' tag in your project
		* @author Kevin Ridgway
		*/
		$branchname = null;
		$file = $root.'/../.git/HEAD';

		if (file_exists($file)) {
			$stringfromfile = file($file, FILE_USE_INCLUDE_PATH);

			$firstLine = $stringfromfile[0]; //get the string from the array

			$explodedstring = explode("/", $firstLine, 3); //seperate out by the "/" in the string

			$branchname = $explodedstring[2]; //get the one that is always the branch name
			$branchname = trim(preg_replace('/\s+/', ' ', $branchname));
		}

		return $branchname;
}
