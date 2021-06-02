#!/usr/bin/env sh
cd /config
[ ! -e start.sh ] && cp /app/upodder/config/start.sh .
[ ! -e subscriptions.yaml ] && cp /app/upodder/config/subscriptions.yaml .
chmod +x start.sh

_term() {
  echo "Caught SIGTERM signal!"
  kill -SIGTERM "$child"
  wait "$child"
  exit 143; # 128 + 15 -- SIGTERM
}
trap _term SIGTERM
./start.sh &
child="$!"
wait "$child"
