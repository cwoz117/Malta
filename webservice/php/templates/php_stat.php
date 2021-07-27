<!DOCTYPE html>
<html>
<body>

<h1>PHP Statistics</h1>
<p>The assignment mentioned that nginx should have both "php and php-fpm statistics page" which I'm interpreting as a requirement for a php-statistics page as well as php-fpm /status.</p>
<p>However, my google-fu only returned values for php statistics libraries, so I'm just going to include a php -v output until a better option reveals itself</p>

<h2> php -v</h2>
<?php
	$output = shell_exec('php -v');
	echo "<p>$output</p>"
?>

</body>
</html> 






