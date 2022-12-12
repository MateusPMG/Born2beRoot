#!/bin/bash

echo "Operating system: $(. /etc/os-release; echo "$NAME" "$VERSION")"
echo "Kernel: $(uname -r)"
echo "Physical Processors, CPUs: $(nproc)"
echo "Virtual Processors, VCPUs: $(cat /proc/cpuinfo | grep processor | wc -l)"
free --mega| grep Mem | awk '{ printf("RAM Usage: %.2f/%.2fMb (%.2f%%)\n", $3, $2, $3/$2 * 100.0) }'
df -h| grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} {fd+= $2} END {printf("Total Disk: %.2fGb/%.2fGb (%.2f%)\n", ud, fd, ud/fd*100) }'
top -bn1 | grep '^%Cpu' | cut -c 9- | awk '{printf("CPU load: %.1f%%\n"), $1+$2+$3}'
who -b | cut -c 22- | awk '{print("Last reboot: "$1 " " $2)}'
