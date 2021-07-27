<!DOCTYPE html>
<html>
<body>

<h1>Latency Check</h1>
<p>This basic stats page should display the connection status to MySQL and Redis, with a latency value.</p>
<p>I'm probably just going to run a shell-exec to ping the boxes, and return parsed results ??</p>

<h2>MySQL Status</h2>
<?php
  $output = shell_exec('ping -c 5 mysql');
  echo "<pre>$output</pre>";
?>
<h2>Redis Status</h2>
<?php
  $output = shell_exec('ping -c 5 redis');
  echo "<pre>$output</pre>";
?>

</body>
</html> 
