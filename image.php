<?php
session_start();
$code = rand(1000, 9999);
$_SESSION['captcha'] = $code;

header('Content-Type: image/png');
$image = imagecreate(70, 30);
$bg = imagecolorallocate($image, 240, 240, 240);
$txt = imagecolorallocate($image, 0, 0, 0);
imagestring($image, 5, 10, 5, $code, $txt);
imagepng($image);
imagedestroy($image);
?>
