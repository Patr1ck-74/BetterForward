# 使用 Python 3.12 Alpine 版本
FROM python:3.12-alpine

# 设置工作目录
WORKDIR /app

# 复制项目文件
ADD main.py /app
ADD locale /app/locale
ADD db_migrate /app/db_migrate
ADD requirements.txt /app
ADD app.py /app

# 删除翻译文件
RUN find /app/locale -name "*.po" -type f -delete

# 创建数据目录
RUN mkdir /app/data

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install flask   # 保证 Flask 可用
RUN rm requirements.txt

# 设置环境变量（保持原有变量）
ENV TOKEN="7548819821:AAEl3-B3TnCu8nv-_bLR_jFGCztuce9CHVo"
ENV GROUP_ID="-1002664447385"
ENV LANGUAGE="zh_CN"
ENV TG_API=""

# 暴露端口给 Render 健康检查
EXPOSE 5000

# 启动 Flask + Bot
CMD sh -c "python -u /app/main.py -token \"$TOKEN\" -group_id \"$GROUP_ID\" -language \"$LANGUAGE\" -tg_api \"$TG_API\" & python /app/app.py"
