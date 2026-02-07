FROM tarioch/fava

RUN apt update\
    && apt install -y ghostscript git vim tmux cron

COPY requirements.txt .

RUN pip install -r requirements.txt

# If any dependency installed ibflex from PyPI/git, remove it
RUN pip uninstall -y ibflex || true

# Re‑install ibflex2 so that `import ibflex` imports the maintained fork
RUN pip install --force-reinstall --no-deps ibflex2

RUN touch /var/log/cron.log
# Setup cron job
RUN (crontab -l ; echo "10 23 * * * /bin/bash /myData/cron.daily > /myData/cron.log 2>&1") | crontab
