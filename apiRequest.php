<?php
$url = "https://api.chucknorris.io/jokes/random"; // 获取随机笑话
$response = file_get_contents($url);

if ($response !== false) {
    $data = json_decode($response, true);
    echo "笑话: " . $data['value'];
} else {
    echo "无法获取数据。";
}
?>
