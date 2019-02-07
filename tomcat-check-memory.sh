#!/usr/bin/env bash
#
# This script was born to monitor a unix machine from being overwhelmed by the tomcat process.
# We had a memory leak in an application and we were too lazy and in a hurry to solved the issue.
# That's why we decided to ignore the problem and to add this monitoring script in cron.
# If the Tomcat memory overcame a threshold, we sent a mail.

# Configuration part
# Numbers of MegaByte which should not be passed
threshold=150;
# Mail to notify in case tomcat passes the threshold
mailToNotify="myself@mail.me";
# Mail sender
mailFrom="dying-tomcat@mail.com";

# Execution part
psaux=$(ps -aux --sort -rss | grep apache-tomcat | head -n 1);
mem=$(echo "$psaux" | tr -s " " | cut -d " " -f4);
host=$(hostname);
#echo "Tomcat memory is $mem";

memPassed=$(echo $mem'>'$threshold | bc)
if ((memPassed == 1))
then
    #echo "Memory Exceeded!";
    printf "Memory of Tomcat is now $mem MB!\nConsider restarting $host." | mail -s "Tomcat Memory limit exceeded" -r $mailFrom $mailToNotify
else
    #echo "Everything is ok";
fi;

 # 0 * * * * root bash /root/cronscript/tomcatcheck.sh >/dev/null 2>&1
