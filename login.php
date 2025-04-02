<?php
session_start();

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';

// 模拟用户名和密码
$valid_user = 'admin';
$valid_pass = '123456';

if ($username === $valid_user && $password === $valid_pass) {
    $_SESSION['user'] = $username;
    echo "登录成功！欢迎回来，$username";
} else {
    echo "用户名或密码错误。";
}
?>
