# 使用 Python 3.12 Alpine 轻量镜像
FROM python:3.12-alpine

# 设置工作目录
WORKDIR /app

# 添加代码文件
ADD main.py /app
ADD app.py /app       # 新增 app.py，作为启动入口
ADD locale /app/locale
ADD db_migrate /app/db_migrate
ADD requirements.txt /app

# 删除翻译文件避免冗余
RUN find /app/locale -name "*.po" -type f -delete

# 创建数据目录
RUN mkdir /app/data

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt

# 设置环境变量
ENV TOKEN="7548819821:AAEl3-B3TnCu8nv-_bLR_jFGCztuce9CHVo"
ENV GROUP_ID="-1002664447385"
ENV LANGUAGE="zh_CN"
ENV TG_API=""

# 暴露 Render 健康检查端口
EXPOSE 5000

# 启动容器，读取环境变量
CMD ["python", "app.py"]
