#!/bin/bash

# 定义变量
LOG_FILE="/var/log/rivalz_restart.log"
SCREEN_NAME="rivalz"

# 定义重启函数
restart_rivalz() {
    # 查找并杀掉指定的 screen 会话
    if screen -list | grep -q "$SCREEN_NAME"; then
        screen -S "$SCREEN_NAME" -X quit
        echo "$(date): Screen $SCREEN_NAME stopped." >> "$LOG_FILE"
    else
        echo "$(date): No running screen $SCREEN_NAME found." >> "$LOG_FILE"
    fi

    # 启动新的 screen 会话
    screen -dmS "$SCREEN_NAME" bash -c "rivalz run; exec bash"
    echo "$(date): Screen $SCREEN_NAME started." >> "$LOG_FILE"
}

# 配置 cron 任务
setup_cron() {
    echo "Configuring cron job..."
    # 获取当前脚本的完整路径
    SCRIPT_PATH=$(realpath "$0")
    # 将任务添加到 cron
    (crontab -l 2>/dev/null; echo "0 2 * * * bash $SCRIPT_PATH restart") | crontab -
    echo "Cron job added: runs daily at 2:00 AM."
}

# 主逻辑
if [[ "$1" == "restart" ]]; then
    # 执行重启逻辑
    restart_rivalz
else
    # 配置 cron 并测试重启
    setup_cron
    echo "Testing restart function..."
    restart_rivalz
    echo "Setup complete. Logs can be found in $LOG_FILE."
fi
