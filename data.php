<?php
// 数据库连接配置
$host = 'localhost';
$dbname = 'your_database_name';
$user = 'your_username';
$pass = 'your_password';

// 创建数据库连接
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 查询用户数据
    $stmt = $pdo->query("SELECT * FROM users");

    echo "<h2>用户列表：</h2>";
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "用户名: " . htmlspecialchars($row['username']) . "<br>";
    }
} catch (PDOException $e) {
    echo "数据库连接失败: " . $e->getMessage();
}
?>
