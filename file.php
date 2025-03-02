<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['upload'])) {
    $targetDir = "uploads/";
    $targetFile = $targetDir . basename($_FILES["upload"]["name"]);

    if (move_uploaded_file($_FILES["upload"]["tmp_name"], $targetFile)) {
        echo "文件上传成功：" . htmlspecialchars($_FILES["upload"]["name"]);
    } else {
        echo "文件上传失败。";
    }
}
?>
