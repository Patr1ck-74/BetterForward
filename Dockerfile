FROM python:3.12-alpine

WORKDIR /app
ADD main.py /app
ADD locale /app/locale
RUN find /app/locale -name "*.po" -type f -delete
ADD db_migrate /app/db_migrate
ADD requirements.txt /app

RUN mkdir /app/data
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt

ENV TOKEN="7548819821:AAEl3-B3TnCu8nv-_bLR_jFGCztuce9CHVo"
ENV GROUP_ID="-1002664447385"
ENV LANGUAGE="zh_CN"
ENV TG_API=""

CMD python -u /app/main.py -token "$TOKEN" -group_id "$GROUP_ID" -language "$LANGUAGE" -tg_api "$TG_API"
