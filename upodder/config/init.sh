#!/usr/bin/env sh
cd /config
[ ! -e start.sh ] && cp /app/upodder/config/start.sh .
[ ! -e subscriptions.yaml ] && cp /app/upodder/config/subscriptions.yaml .
[ ! -e crontab ] && cp /app/upodder/config/crontab .

sh start.sh