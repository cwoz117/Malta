<!DOCTYPE html>
<html>
<body>

<h1>Latency Check</h1>
<p>This basic stats page should display the connection status to MySQL and Redis, with a latency value.</p>
<p>I'm probably just going to run a shell-exec to ping the boxes, and return parsed results ??</p>

<h2>MySQL Status</h2>
<?php
$con = mysqli_connect("mysql","root","root","test_db");

// Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  exit();
}
echo "<p> Connected Successfully</p>"
?>
<h2>Redis Status</h2>
<?php 
   $redis = new Redis(); 
   $redis->connect('redis', 6379); 
   echo "<p>Connected Sucessfully</p>"; 
?>

</body>
</html> 
