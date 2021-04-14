#!/usr/bin/env sh
#echo "nameserver 8.8.8.8" > /etc/resolv.conf
#echo "options ndots:0" >> /etc/resolv.conf

TROJAN_CONFIG_FILE="/config/config.json"
UPODDER_CMD="/app/upodder/upodder.py --basedir=/config --podcastdir=/data --quiet"
# Temporary files
ENV_FILE="/tmp/.env"
CRON_JOB_FILE="/tmp/cron_job.sh"
CRONTAB_FILE="/tmp/crontab"
# log files
TROJAN_LOG_FILE="/data/trojan.log"
UPODDER_LOG_FILE="/data/uppoder.cron.log"

# Start trojan client
[ -e ${TROJAN_CONFIG_FILE} ] && trojan ${TROJAN_CONFIG_FILE} >> ${TROJAN_LOG_FILE} 2>&1 &

# Build the command and start a cron job scheduler
export > ${ENV_FILE}
echo "#!/usr/bin/env sh" > ${CRON_JOB_FILE}
echo "source ${ENV_FILE}; ${UPODDER_CMD} >> ${UPODDER_LOG_FILE} 2>&1" >> ${CRON_JOB_FILE}
chmod +x ${CRON_JOB_FILE}
echo "*/30 * * * * /usr/bin/flock -n /tmp/fcj.lockfile ${CRON_JOB_FILE}" > ${CRONTAB_FILE}
cat ${CRONTAB_FILE} >> ${UPODDER_LOG_FILE}
crontab ${CRONTAB_FILE}
crond -f
