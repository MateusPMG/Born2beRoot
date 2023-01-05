#!/bin/bash

wall "
Architecture: $(uname -a)
Physical Processors, CPUs: $(nproc)
Virtual Processors, VCPUs: $(cat /proc/cpuinfo | grep processor| wc -l)
$(free --mega | grep Mem | awk '{ printf("RAM usage: %.2f/%.2fMb (%.2f%%)\n", $3, $2, $3/$2 * 100.0) }')
$(df -h --total| grep total | awk '{ printf("Total Disk: %.2f/%.2fGb (%.2f%%)\n", $3, $2, $5) }')
$(top -bn1 | grep '^%Cpu' | cut -c 9- | awk '{printf("CPU load: %.1f%%\n"), $1+$2+$3}')
$(who -b | cut -c 22- | awk '{print("Last reboot: "$1 " " $2)}')
Connections TCP: $(ss -tn src :4242 |grep -i "estab" | wc  -l) Established
User log: $(who | wc -l)
Network: IP $(hostname -I) ($(ip addr | grep ether | awk '{ print($2) }'))
Sudo: $(cat /var/log/sudo/sudolog.log | wc -l | awk '{ print $1/2  }') cmd
$(if grep -q /dev/mapper /etc/fstab
	then
echo "LVM in use"
	else
echo "LVM not in use"
	fi)
	"