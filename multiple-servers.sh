#!/bin/bash
# Ping a list of IP addresses.
# Copy all the logs from a list of remote servers.

IP_FILE="/tmp/ips" # The file with the IP addresses
LOGFILE="/tmp/log_results"  # Where the results will be stored


if [[ ! -f ${IP_FILE} ]]; then
   echo "No File!"
   exit 1
fi

for IP_ADDRESS in $(cat $IP_FILE); do
   echo "TEST FOR ${IP_ADDRESS}" >> $LOGFILE
   # The -c 1 means send one packet, and the -t 1 means a 1 second timeout    
   ping -c 1 -t 1 ${IP_ADDRESS} >> $LOGFILE 2>&1
   scp -r ${IP_ADDRESS}:/var/log/ /tmp/copied-logs/${IP_ADDRESS}/
done
