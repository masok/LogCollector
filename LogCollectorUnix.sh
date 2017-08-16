#/bin/bash

#Directory for logs folder of XXX
logs_dir=/var/log/XXX
logsstat=/opt/XXX/Statistics
events_dir=/var/log
product_root="/var/opt/XXX"
templogs=/tmp/"TechSUppLogs($(date +%m-%d-%Y))"

#Create temp logs folder
mkdir $templogs 

while :
do
echo -en '\n'
echo "Welcome to XXX Log Collector"
echo -en '\n' 
echo "...................................................."
echo "Press 1, 2, 3, 4, 5, 6 or 7 and Enter to select your task. Or 8 to exit."
echo "...................................................."
echo -en '\n' 
echo " Select an option "
echo -en '\n' 
echo "1. Collect Desktop logs & Installation History"
echo "2. Collect Statistics Logs"
echo "3. Collect System Information"
echo "4. Collect Web Logs"
echo "5. Collect Mobile Logs"
echo "6. Collect Events"
echo "7. Collect All Logs"
echo "8. Exit"
echo -n "Select an option [1 - 8] and press Enter: "
read opcion
case $opcion in


#Copy Desktop log files to temp folder
1) echo "LogsDesk and Installation History";
mkdir $templogs/LogsDesk
cp $logs_dir/LogsDesk.log $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak00 $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak01 $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak02 $templogs/LogsDesk

cp $logs_dir/InstallationHistory.hist $templogs
;;

#Copy Statistic logs
2) echo "Installation History";
mkdir $templogs/Statistics
cp $logsstat/Statistics.xml $templogs/Statistics
;;

#Copy System Information
3) echo "System Information";
echo "System Information" > $templogs/SystemInformation.txt 
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Hostname" >> $templogs/SystemInformation.txt
hostname --fqdn >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Kernel" >> $templogs/SystemInformation.txt
uname -a >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "CPU Info" >> $templogs/SystemInformation.txt
cat /proc/cpuinfo >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Memory" >> $templogs/SystemInformation.txt
free >> $templogs/SystemInformation.txt
;;

#Locate and copy Web logs
4) echo "Web Logs";
mkdir $templogs/Web
locate "*/XXX/WEB-INF/log/templogs*" | xargs cp -t $templogs/Web
;;

#Locate and copy Mobile logs
5) echo "Mobile Logs";
mkdir $templogs/Mobile
locate "*/XXXMobile/WEB-INF/log/templogs*" | xargs cp -t $templogs/Mobile
;;

#Collect Events
6) echo "Collecting Events";
cp $events_dir/dmesg $templogs/dmesg.txt
cp $events_dir/messages $templogs/messages.txt
cp $events_dir/yum.log $templogs/yum.txt
;;

#Collect all logs
7) echo "Collecting All Logs";
echo "LogsDesk and Installation History";
mkdir $templogs/LogsDesk
cp $logs_dir/LogsDesk.log $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak00 $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak01 $templogs/LogsDesk
cp $logs_dir/LogsDesk.log.bak02 $templogs/LogsDesk

cp $logs_dir/InstallationHistory.hist $templogs

echo "Installation History";
mkdir $templogs/Statistics
cp $logsstat/MAEntMgr.xml $templogs/Statistics

echo "System Information";
echo "System Information" > $templogs/SystemInformation.txt 
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Hostname" >> $templogs/SystemInformation.txt
hostname --fqdn >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Kernel" >> $templogs/SystemInformation.txt
uname -a >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "CPU Info" >> $templogs/SystemInformation.txt
cat /proc/cpuinfo >> $templogs/SystemInformation.txt
echo -en '\n' >> $templogs/SystemInformation.txt
echo "Memory" >> $templogs/SystemInformation.txt
free >> $templogs/SystemInformation.txt

echo "Web Logs";
mkdir $templogs/Web
locate "*/XXX/WEB-INF/log/templogs*" | xargs cp -t $templogs/Web

echo "Mobile Logs";
mkdir $templogs/Mobile
locate "*/XXXMobile/WEB-INF/log/templogs*" | xargs cp -t $templogs/Mobile

echo "Collecting Events";
cp $events_dir/dmesg $templogs/dmesg.txt
cp $events_dir/messages $templogs/messages.txt
cp $events_dir/yum.log $templogs/yum.txt
;;

#Exit
8) echo "Exit";
zip -r /tmp/TechSuppLogs.zip $templogs
exit 1;;

#If the option selected is invalid
*) echo "Option Invalid";
echo "Press any key to continue..";
;;
esac
done