<?php include('login.php'); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Script</title>
	<style type="text/css">
	html{font-family: "arial", sans-serif;}
	a{padding:5px 8px; background-color: #525252; text-decoration: none; color:#fff; font-size: 0.8em; display: inline-block;}
	a:hover, a.hover{background-color: #828282;}
	a.klar{background-color: #82aa2f;}
	a.ikke{background-color: #c73939;}
	#slett{background: red; color:white; padding:5px; text-decoration: none; margin-top: 20px;}

	</style>
</head>
<body>
<?php
if (!$loggedIn && isset($_POST['pass']) && $_POST['pass'] == $pass) {
    $_SESSION['pass'] = $pass;
    $loggedIn = true;
}

if (!$loggedIn) {?>
    <form method="post" id="login">
        <input name="pass">
        <button type="submit">Logg inn</button>
    </form>
<?php
} else {
?>

<h1>Side for diverse script</h1>
<p><a href="download.php">Download assets</a> <span style="font-size: 11px;">legges i /script/zip/zips</span></p>
<?php
echo 'PHP version: '.phpversion();
} ?>
</body>
</html>
