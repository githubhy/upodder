#!/usr/bin/env sh
cd /config
[ -e config.json ] && trojan config.json >> /data/trojan.log 2>&1 &
export > /root/.env
cat crontab >> /data/uppoder.cron.log
#echo "nameserver 8.8.8.8" > /etc/resolv.conf
#echo "options ndots:0" >> /etc/resolv.conf
crontab crontab
crond -f
