#!/bin/bash
. /etc/profile.d/CP.sh
. /etc/profile.d/vsenv.sh
#
# Script: infocollector2.sh
# last update 20260624
# Script by : VK Prasad, Professional Services Consultant
# Copyrights:  Check Point Software Technologies LTD.
#
##############
# Version tracking
##############
# v1 - Initial script to collet important info
# v2 - Major change, improvements in many areas and clish save config
# v2.1 - SD-WAN checks, CRL checks
# v2.2 - ISP redundancy, reverse proxy cli checks
# v2.3 - maas status checks 
# v2.3 - VSX configurations
# v2.4 - Added interface status and updated ethtool, added Management info 51, enhanced chk 28
# 
##############
# REMOVE OLD FILES
rm -rf /var/tmp/hostname-infocollector2.txt
rm -rf $HOSTNAME-infocollector2.txt
#
# SCRIPT
clish -c "lock database override" >> $HOSTNAME-infocollector2.txt 2>&1
clish -c "show configuration hostname" | awk '{print $3}' >> /var/tmp/hostname-infocollector2.txt
# Variable declaration
HOSTNAME=`cat /var/tmp/hostname-infocollector2.txt`
VER="v2.4"
DATE=$(date +"%Y%m%d_%H%M%S")
PWD=$(pwd)
#
printf ""
printf "%s\n" "--------infocollector2 $VER outputs of $HOSTNAME on $DATE--------" >> $HOSTNAME-infocollector2.txt 2>&1
printf ""
echo "--------infocollector2 $VER of $HOSTNAME on $DATE, following outputs are being collected--------"
echo ""
#
echo "01. Configuration Backup"
	printf "%s\n" "---Configuration Backup---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show configuration" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show configuration" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---uptime---" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	uptime >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Saving the clish configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "save config" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "save config"
	printf "%s\n" "Saved Gaia configuration successfully" >> $HOSTNAME-infocollector2.txt 2>&1
	rm -rf /var/tmp/hostname-infocollector2.txt
	printf "%s\n" "---show snapshots---" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show snapshots" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "02. Asset Information"
	printf "%s\n" "---Asset Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show asset all" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show asset all" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "03. Hardware Built Version"
	printf "%s\n" "---Hardware Built Version---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show version all" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show version all" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "04. Deployment Agent Version"
	printf "%s\n" "---Deployment Agent Version---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show installer status" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show installer status" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "05. License Information"
	printf "%s\n" "---License Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cplic print -x" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cplic print -x >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---License Entitlement---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat os -f licensing" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat os -f licensing >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "06. Jumbo Hot Fixes"
	printf "%s\n" "---Jumbo Hot Fixes---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpinfo -y all" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpinfo -y all >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
	printf "%s\n" "---OS details---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat os" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat os >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
	printf "%s\n" "---kernal details---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "uname -a" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	uname -a >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "07. Logging Status"
	printf "%s\n" "---Logging Status on Gateway---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat fw -f log_connection" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat fw -f log_connection >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Logging Status on SMS---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat mg -f log_server" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat mg -f log_server >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---CP log export status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cp_log_export show" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cp_log_export show >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Log Server connection status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "netstat -an | grep 257" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	netstat -an | grep 257 >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Masters file---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cat $FWDIR/conf/masters" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cat $FWDIR/conf/masters >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "08. Core Dump Check"
	printf "%s\n" "---Core Dump Check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "ls -lhs /var/log/dump/usermode/" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ls -lhs /var/log/dump/usermode/ >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "09. Registry Corruption Check"
	printf "%s\n" "---Registry Corruption Check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "ls -lhs $CPDIR/registry/" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ls -lhs $CPDIR/registry/ >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "10. Internet Connectivity Test"
	printf "%s\n" "---Whats my IP---" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "curl_cli ifconfig.me" >> $HOSTNAME-infocollector2.txt 2>&1
	curl_cli ifconfig.me >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Internet Connectivity Test---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "curl_cli -kv -x X.X.X.X:YYY https://updates.checkpoint.com" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show configuration proxy" >> /var/tmp/proxycheck-infocollector2.txt 2>&1
	PROXYCONFIGURATION=`cat /var/tmp/proxycheck-infocollector2.txt`
	if [[ $PROXYCONFIGURATION == *"proxy address"* ]]; then
		echo "Proxy Configuration Exists" >> $HOSTNAME-infocollector2.txt 2>&1
			clish -c "show configuration proxy" | awk '{print $4}' >> /var/tmp/proxyip-infocollector2.txt
			clish -c "show configuration proxy" | awk '{print $6}' >> /var/tmp/proxyport-infocollector2.txt
			PROXYIP=`cat /var/tmp/proxyip-infocollector2.txt`
			PROXYPORT=`cat /var/tmp/proxyport-infocollector2.txt`
			curl_cli -kv --proxy $PROXYIP:$PROXYPORT https://updates.checkpoint.com >> $HOSTNAME-infocollector2.txt 2>&1
			rm -rf /var/tmp/proxyip-infocollector2.txt
			rm -rf /var/tmp/proxyport-infocollector2.txt
	else
		echo "Proxy Configuration Does Not Exist" >> $HOSTNAME-infocollector2.txt 2>&1
			curl_cli -vk https://updates.checkpoint.com >> $HOSTNAME-infocollector2.txt 2>&1
	fi
	rm -rf /var/tmp/proxycheck-infocollector2.txt
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "11. High Availability Status"
	printf "%s\n" "---High Availability Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cphaprob state" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cphaprob state >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---High Availability failures---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cphaprob show_failover" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cphaprob show_failover >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "12. High Availability Interface Status"
	printf "%s\n" "---High Availability Interface Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cphaprob -a if" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cphaprob -a if >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Open Server specific Interface, bus details---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\ncat /etc/udev/rules.d/00-OS-XX.rules" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cat /etc/udev/rules.d/00-OS-XX.rules >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "13. High Availability PNOTE Status"
	printf "%s\n" "---High Availability PNOTE Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cphaprob -l list" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cphaprob -l list >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "14. Interface Detailed Information"
	printf "%s\n" "---Interface Detailed Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "ifconfig" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ifconfig >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---LOM status---" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	lominfo >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n%s\n" "---ethtool for all interfaces" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n%s\n" "show interfaces all port" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show interfaces all port" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n%s\n" "show interfaces all overview" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show interfaces all overview" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ifconfig | grep Link | awk '{print $1}' >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ifconfig | grep Link | awk '{print $1}' > /var/tmp/interfaces-infocollector2.txt
		for INTERFACE in $(cat /var/tmp/interfaces-infocollector2.txt) 
			do
			ethtool $INTERFACE >> $HOSTNAME-infocollector2.txt 2>&1
		done
	rm -rf /var/tmp/interfaces-infocollector2.txt
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "15. Interface IP Information"
	printf "%s\n" "---Interface IP Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat fw -f interfaces" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat fw -f interfaces >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "16. Routing Information"
	printf "%s\n" "---Routing Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show route" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show route" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show ospf neighbors" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show ospf neighbors" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show bgp summary" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show bgp summary" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show bgp peers detailed" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show bgp peers detailed" >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "17. Netstat Interface Information"
	printf "%s\n" "---Netstat Interface Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "netstat -ni" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	netstat -ni >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "18. Ring Size Configuration"
	printf "%s\n" "---Ring Size Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---ethtool -g ethX" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ifconfig | grep Link | awk '{print $1}' > /var/tmp/interfaces-infocollector2.txt
		for INTERFACE in $(cat /var/tmp/interfaces-infocollector2.txt) 
			do
			ethtool -g $INTERFACE >> $HOSTNAME-infocollector2.txt 2>&1
		done
	rm -rf /var/tmp/interfaces-infocollector2.txt
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "19. Bonding Configuration"
	printf "%s\n" "---Bonding Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	BONDINGCHECK=/proc/net/bonding/
	if [[ -d "$BONDINGCHECK" ]]; then
		printf "%s\n" "cat /proc/net/bonding/bondX" >> $HOSTNAME-infocollector2.txt 2>&1
		echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		ls /proc/net/bonding/ >> /var/tmp/bonding-infocollector2.txt
		for BOND in $(cat /var/tmp/bonding-infocollector2.txt) 
			do
			printf "%s\n" "Configuration for $BOND" >> $HOSTNAME-infocollector2.txt 2>&1
			cat /proc/net/bonding/$BOND | grep -i "Aggregator ID" >> $HOSTNAME-infocollector2.txt 2>&1
			cat /proc/net/bonding/$BOND | grep -i "mac" >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		done
		rm -rf /var/tmp/bonding-infocollector2.txt
	else
		printf "%s\n" "Bond Configuration Does Not Exist" >> $HOSTNAME-infocollector2.txt 2>&1
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "20. NTP Status"
	printf "%s\n" "---NTP Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show ntp active" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show ntp active"  >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show ntp current"  >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c "show ntp servers"  >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ntpq -c peers  >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "clock" >> $HOSTNAME-infocollector2.txt 2>&1
	clock >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "21. Hyper Threading Status"
	printf "%s\n" "---Hyper Threading Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	uname -r >> /var/tmp/uname-infocollector2.txt 2>&1
	KERNELVERSION=`cat /var/tmp/uname-infocollector2.txt`
	if [[ $KERNELVERSION == *"3.10.0-957.21.3cpx86_64"* ]]; then
		printf "%s\n" "cat /sys/devices/system/cpu/smt/active" >> $HOSTNAME-infocollector2.txt 2>&1
		cat /sys/devices/system/cpu/smt/active >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/uname-infocollector2.txt
	else
		printf "%s\n" "cat /proc/smt_status" >> $HOSTNAME-infocollector2.txt 2>&1
		cat /proc/smt_status >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/uname-infocollector2.txt
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "22. Enabled Blades"
	printf "%s\n" "---Enabled Blades---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "enabled_blades" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	enabled_blades >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "23. Top CPU Information "
	printf "%s\n" "---Top CPU Information for All CPUs---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "top -b -n1" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	top -b -n1 >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "24. MPSTAT CPU Usage"
	printf "%s\n" "---MPSTAT CPU Usage---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "mpstat -P ALL" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	mpstat -P ALL >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "25. Memory Information"
	printf "%s\n" "---Memory Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "free -mgt" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	free -mgt >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "26. Disk Space"
	printf "%s\n" "---Disk Space---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat os -f multi_disk" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat os -f multi_disk >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---disk info---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "df -h" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	df -h >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---raid status---" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	raid_diagnostic >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "27. CP Watch Dog"
	printf "%s\n" "---CP Watch Dog---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpwd_admin list" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpwd_admin list >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---CP Watch Dog Verbose---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpwd_admin list -full" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpwd_admin list -full >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "28. Policy Status - FWStat"
	printf "%s\n" "---Policy Status - FWStat---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw stat -l" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw stat -l >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---AMW Policy Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw stat -b AMW" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw stat -b AMW >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---AMW update status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat antimalware -f update_status" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat antimalware -f update_status >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---IPS stat---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "ips stat" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ips stat >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "29. Dynamic Split Status"
	printf "%s\n" "---Dynamic Split Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	fw ver | awk '{print $7}' >> /var/tmp/fwversion-infocollector2.txt 2>&1
	FWVERSION=`cat /var/tmp/fwversion-infocollector2.txt`
	cpinfo -y FW1 >> /var/tmp/jhf-infocollector2.txt 2>&1
	cat /var/tmp/jhf-infocollector2.txt | grep Take | awk '{print $3}' >> /var/tmp/jhfversion-infocollector2.txt
	JHFVERSION=`cat /var/tmp/jhfversion-infocollector2.txt`
	if [[ $FWVERSION == *"R80.40"* ]] && [[ $JHFVERSION -ge "25" ]]; then
		printf "%s\n" "dynamic_split -p" >> $HOSTNAME-infocollector2.txt 2>&1
		dynamic_split -p >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/jhf-infocollector2.txt
		rm -rf /var/tmp/fwversion-infocollector2.txt
		rm -rf /var/tmp/jhfversion-infocollector2.txt
	elif [[ $FWVERSION == *"R81"* ]] || [[ $FWVERSION == *"R81.10"* ]] || [[ $FWVERSION == *"R81.20"* ]] || [[ $FWVERSION == *"R82"* ]] || [[ $FWVERSION == *"R82.10"* ]]; then
		printf "%s\n" "dynamic_split -p" >> $HOSTNAME-infocollector2.txt 2>&1
		dynamic_split -p >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/jhf-infocollector2.txt
		rm -rf /var/tmp/fwversion-infocollector2.txt
		rm -rf /var/tmp/jhfversion-infocollector2.txt
	else
		printf "%s\n" "Dynamic Split is not supported" >> $HOSTNAME-infocollector2.txt 2>&1
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "30. CoreXL Distribution"
	printf "%s\n" "---CoreXL Distribution---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw ctl affinity -l -a -v" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw ctl affinity -l -a -v >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "31. Connection Information Per CPU"
	printf "%s\n" "---CoreXL Distribution---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw ctl multik stat" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw ctl multik stat >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "32. Connection Table Information"
	printf "%s\n" "---Connection Table Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw tab -s -t connections" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw tab -s -t connections >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "33. Kernel Memory Information"
	printf "%s\n" "---Kernel Memory Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw ctl pstat" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw ctl pstat >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "34. SecureXL Status"
	printf "%s\n" "---SecureXL Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fwaccel stat" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fwaccel stat >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "35. SecureXL Statistics"
	printf "%s\n" "---SecureXL Statistics---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fwaccel stats -s" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fwaccel stats -s >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Fast Accel Status---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "fw ctl fast_accel show_table" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	fw ctl fast_accel show_table >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
	printf "%s\n" "---Drop packet statistics---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cat /proc/ppk/drop_statistics" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cat /proc/ppk/drop_statistics >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "36. SIM Affinity"
	printf "%s\n" "---SIM Affinity---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "sim affinity -l" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	sim affinity -l >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "37. Multi-Queue Information"
	printf "%s\n" "---Multi-Queue Information---" >> $HOSTNAME-infocollector2.txt 2>&1
	uname -r >> /var/tmp/uname-infocollector2.txt 2>&1
	KERNELVERSION=`cat /var/tmp/uname-infocollector2.txt`
	if [[ $KERNELVERSION == *"3.10.0-957.21.3cpx86_64"* ]]; then
		printf "%s\n" "mq_mng --show" >> $HOSTNAME-infocollector2.txt 2>&1
		mq_mng --show >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/uname-infocollector2.txt
	else
		printf "%s\n" "cpmq get -vv" >> $HOSTNAME-infocollector2.txt 2>&1
		cpmq get -vv >> $HOSTNAME-infocollector2.txt 2>&1
		rm -rf /var/tmp/uname-infocollector2.txt
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "38. VPN Encryption Domain Overlap"
	printf "%s\n" "---VPN Encryption Domain Overlap---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "vpn overlap_encdom" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "VPN domain overlap check skipped" >> $HOSTNAME-infocollector2.txt 2>&1
#	vpn overlap_encdom >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "39. FWKERN Configuration"
	printf "%s\n" "---FWKERN Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "$FWDIR/boot/modules/fwkern.conf" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	FWKERN=$FWDIR/boot/modules/fwkern.conf
	if [ -f "$FWKERN" ]; then
		echo "$FWKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
		cat $FWKERN >> $HOSTNAME-infocollector2.txt 2>&1
	else 
		echo "$FWKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "40. SIMKERN Configuration"
	printf "%s\n" "---SIMKERN Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "$FWDIR/boot/modules/simkern.conf" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	SIMKERN=$FWDIR/boot/modules/simkern.conf
	if [ -f "$SIMKERN" ]; then
		echo "$SIMKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
		cat $SIMKERN >> $HOSTNAME-infocollector2.txt 2>&1
	else 
		echo "$SIMKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
	fi
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
	printf "%s\n" "---SIMKERN Configuration in PPKDIR---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "$PPKDIR/conf/simkern.conf" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	SIMKERN=$PPKDIR/conf/simkern.conf
	if [ -f "$SIMKERN" ]; then
		echo "$SIMKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
		cat $SIMKERN >> $HOSTNAME-infocollector2.txt 2>&1
	else 
		echo "$SIMKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
	fi
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "41. VPNKERN Configuration"
	printf "%s\n" "---VPNKERN Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "$FWDIR/boot/modules/vpnkern.conf" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	VPNKERN=$FWDIR/boot/modules/vpnkern.conf
	if [ -f "$VPNKERN" ]; then
		echo "$VPNKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
		cat $VPNKERN >> $HOSTNAME-infocollector2.txt 2>&1
	else 
		echo "$VPNKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "42. Proxy ARP Configuration and device ARP details"
	printf "%s\n" "---Proxy ARP Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cat $FWDIR/conf/local.arp" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	PROXYARP=$FWDIR/conf/local.arp
	if [ -f "$PROXYARP" ]; then
		echo "$PROXYARP exists." >> $HOSTNAME-infocollector2.txt 2>&1
		cat $PROXYARP >> $HOSTNAME-infocollector2.txt 2>&1
	else 
		echo "$PROXYARP does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
	fi
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "---Device ARP details---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "show arp dynamic all" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	clish -c 'show arp dynamic all' >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "43. Messages File"
	printf "%s\n" "---Messages File (Last 200 Lines)---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "tail -n 200 /var/log/messages" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	tail -n 200 /var/log/messages >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "44. Malware Configuration settings"
	printf "%s\n" "---Malware Configuration settings---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "$FWDIR/conf/malware_config" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cat $FWDIR/conf/malware_config >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "45. Current VPN tunnel details"
	printf "%s\n" "---Current VPN tunnel details---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "vpn tu list ike" >> $HOSTNAME-infocollector2.txt 2>&1
	vpn tu list ike  >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "vpn tu list ipsec" >> $HOSTNAME-infocollector2.txt 2>&1
	vpn tu list  ipsec >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "vpn tu tlist" >> $HOSTNAME-infocollector2.txt 2>&1
	vpn tu tlist >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "46. ICA Certificates issued"
	printf "%s\n" "---ICA Certificates issued---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpca_client lscert" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpca_client lscert >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "47. Cloud Management Extension Check"
	printf "%s\n" "---VMSS configurations---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "autoprov_cfg show all" >> $HOSTNAME-infocollector2.txt 2>&1
	autoprov_cfg show all >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
	printf "%s\n" "---CloudGuard licensing tool check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "vsec_lic_cli view" >> $HOSTNAME-infocollector2.txt 2>&1
	vsec_lic_cli view >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "48. ReverseProxyCLI rules"
	printf "%s\n" "---ReverseProxyCLI show rules check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "ReverseProxyCLI show rules" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	ReverseProxyCLI show rules >> $HOSTNAME-infocollector2.txt 2>&1
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "49. SD-WAN Service"
	printf "%s\n" "---SD-WAN Services check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpnano -s" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpnano -s >> $HOSTNAME-infocollector2.txt 2>&1	
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "50. ISP redundancy (legacy)"
	printf "%s\n" "---ISP redundancy (legacy)---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "cpstat fw" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat fw >> $HOSTNAME-infocollector2.txt 2>&1	
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "51. Management as as Service Check"
	printf "%s\n" "---Management as as Service Check---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "maas status" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	maas status >> $HOSTNAME-infocollector2.txt 2>&1	
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "52. Management checks"
	printf "%s\n" "---Management Checks---" >> $HOSTNAME-infocollector2.txt 2>&1
	printf "%s\n" "Management Checks" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	api status >> $HOSTNAME-infocollector2.txt 2>&1	
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	cpstat mg >> $HOSTNAME-infocollector2.txt 2>&1	
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	mdsstat >> $HOSTNAME-infocollector2.txt 2>&1	
echo "" >> $HOSTNAME-infocollector2.txt 2>&1
#
echo "53. VSX information"
	printf "%s\n" "---VSX information---" >> $HOSTNAME-infocollector2.txt 2>&1
	# Get VSIDs from 'vsx stat -v'
	VSIDS=$(vsx stat -v 2>/dev/null | awk '
	  /^ *ID[[:space:]]*\|/ {hdr=1; next}
	  hdr && /^[[:space:]]*[0-9]+/ {print $1}
	')
	# If no VSIDs found, treat as non-VSX; otherwise iterate VSes
	if [ -z "$VSIDS" ]; then
		echo "This is not a VSX gateway." >> $HOSTNAME-infocollector2.txt 2>&1
	else
		printf "%s\n" "vsx stat -v" >> $HOSTNAME-infocollector2.txt 2>&1
		echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		vsx stat -v >> $HOSTNAME-infocollector2.txt 2>&1	
		printf "%s\n" "vsx stat -l" >> $HOSTNAME-infocollector2.txt 2>&1
		echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		vsx stat -l >> $HOSTNAME-infocollector2.txt 2>&1	
		for VSID in $VSIDS; do
			echo "-----VSID $VSID : show configuration-----" >> $HOSTNAME-infocollector2.txt 2>&1
			clish -c "set virtual-system $VSID"
			clish -c "show configuration" >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
			echo "-----VSID $VSID : cluster interfaces-----" >> $HOSTNAME-infocollector2.txt 2>&1
			vsenv "$VSID" >> $HOSTNAME-infocollector2.txt 2>&1
			cphaprob stat >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
			cphaprob -a if >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
			clish -c 'show arp dynamic all' >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		#Proxy ARP
			PROXYARP=$FWDIR/conf/local.arp
			if [ -f "$PROXYARP" ]; then
				echo "$PROXYARP exists." >> $HOSTNAME-infocollector2.txt 2>&1
				cat $PROXYARP >> $HOSTNAME-infocollector2.txt 2>&1
			else 
				echo "$PROXYARP does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
			fi
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		#$FWDIR/boot/modules/fwkern.conf
			FWKERN=$FWDIR/boot/modules/fwkern.conf
			if [ -f "$FWKERN" ]; then
				echo "$FWKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
				cat $FWKERN >> $HOSTNAME-infocollector2.txt 2>&1
			else 
				echo "$FWKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
			fi
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		#$FWDIR/boot/modules/simkern.conf
			printf "%s\n" "---SIMKERN Configuration---" >> $HOSTNAME-infocollector2.txt 2>&1
			printf "%s\n" "$FWDIR/boot/modules/simkern.conf" >> $HOSTNAME-infocollector2.txt 2>&1
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
			SIMKERN=$FWDIR/boot/modules/simkern.conf
			if [ -f "$SIMKERN" ]; then
				echo "$SIMKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
				cat $SIMKERN >> $HOSTNAME-infocollector2.txt 2>&1
			else 
				echo "$SIMKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
			fi
		#SIMKERN=$PPKDIR/conf/simkern.conf
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
			SIMKERN=$PPKDIR/conf/simkern.conf
			if [ -f "$SIMKERN" ]; then
				echo "$SIMKERN exists." >> $HOSTNAME-infocollector2.txt 2>&1
				cat $SIMKERN >> $HOSTNAME-infocollector2.txt 2>&1
			else 
				echo "$SIMKERN does not exist." >> $HOSTNAME-infocollector2.txt 2>&1
			fi
			echo "" >> $HOSTNAME-infocollector2.txt 2>&1
		done
	fi
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	#
	echo "" >> $HOSTNAME-infocollector2.txt 2>&1
	echo "---end of the infocollector2 script output---" >> $HOSTNAME-infocollector2.txt 2>&1
#
mv $HOSTNAME-infocollector2.txt $HOSTNAME-infocollector2_$DATE.txt
#cleanup
rm -rf /var/tmp/hostname-infocollector2.txt
#
echo "Script has completed. Output is stored as $PWD/$HOSTNAME-infocollector2_$DATE.txt"
#end of script
