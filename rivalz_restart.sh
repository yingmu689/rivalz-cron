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
    # 清空所有原有任务
    echo "" | crontab -
    echo "Existing cron jobs cleared."
    
    # 添加新的任务：每小时的第10分钟运行
    echo "10 * * * * bash $SCRIPT_PATH restart" | crontab -
    echo "Cron job added: runs every hour at the 10th minute."
}

# 主逻辑
if [[ "$1" == "restart" ]]; then
    # 执行重启逻辑
    restart_rivalz
else
    # 配置 cron 并测试重启逻辑
    fix 脚本
    setup_cron
    echo "Testing restart function..."
    restart_rivalz
    echo "Setup complete. Logs can be found in $LOG_FILE."
fi
