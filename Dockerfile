FROM python:3.9-buster
LABEL authors="maxwell"

WORKDIR /app
COPY requirements.txt generate_token.py run.sh entrypoint.sh ./

RUN sed -i 's#http://deb.debian.org#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

ARG TZ
ARG USERNAME
ARG PASSWORD

RUN  ln -sf /usr/share/zoneinfo/$TZ /etc/timezone && \
     ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
     apt update -y && apt install -y bash cron lsof && \
     echo "${USERNAME},${PASSWORD}" > /app/account.txt && \
     python3 -m venv venv && \
     pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
     pip install -r requirements.txt

# At 05:55 on every 10th day-of-month. https://crontab.guru/#55_5_*/10_*_*
RUN echo "55 5 */10 * * bash /app/run.sh > /app/cron.log 2>&1 &" | crontab -
EXPOSE 3000
RUN chmod +x *.sh
ENTRYPOINT ["/app/entrypoint.sh"]
