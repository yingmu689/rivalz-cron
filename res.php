<?php
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo json_encode(["msg" => "GET 请求成功"]);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents("php://input"), true);
    echo json_encode(["你提交了" => $input]);
} else {
    http_response_code(405);
    echo json_encode(["error" => "不支持该方法"]);
}
?>
