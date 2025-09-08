import os
import threading
from flask import Flask
from main import main  # 确认 main.py 中有 main() 或 run_bot() 函数启动 Bot

app = Flask(__name__)

@app.route("/")
def index():
    return "OK", 200

def start_bot():
    # 启动原来的 Bot
    main()  # 或者改成你 main.py 里实际的启动函数

# 后台线程启动 Bot
bot_thread = threading.Thread(target=start_bot, daemon=True)
bot_thread.start()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
