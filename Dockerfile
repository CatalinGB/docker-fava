FROM tarioch/fava

RUN apt update\
    && apt install -y ghostscript git vim tmux cron

COPY requirements.txt .

RUN pip install -r requirements.txt

RUN touch /var/log/cron.log
# Setup cron job
RUN (crontab -l ; echo "10 23 * * * /bin/bash /myData/cron.daily > /myData/cron.log 2>&1") | crontab
