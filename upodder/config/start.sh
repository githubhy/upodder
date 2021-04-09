#!/usr/bin/env sh
cd /config
[ -e config.json ] && trojan config.json >> /data/trojan.log 2>&1 &
cat crontab >> /data/uppoder.cron.log
crontab crontab
crond -f
