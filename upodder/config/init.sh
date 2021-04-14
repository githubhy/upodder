#!/usr/bin/env sh
cd /config
[ ! -e start.sh ] && cp /app/upodder/config/start.sh .
[ ! -e subscriptions.yaml ] && cp /app/upodder/config/subscriptions.yaml .

sh start.sh