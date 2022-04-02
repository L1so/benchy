# Benchy - AIO Benchmark script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to make it more efficient.

## Feature
* Basic server information, this include but not limited to:
	* Operating System
	* CPU Model
	* CPU Core Count
	* Virtualization used (**systemd only**)
	* Disk (Count and Usage)
	* Memory (Count and Usage)
	* Swap size
* IPv4 Check
* IPv6 Check
* Server Geolocation
* Server Uptime
* Fallback to `wget` if `curl` is not installed (this applied to Debian based system, where `curl` is not installed by default) 

## Requirement
This section covers various Linux Distribution supported by benchy, each test conducted on clean LXC container.

| Distribution | Minimal Version |
| --- | --- |
| Ubuntu | 14.04 |
|Debian|7|
| CentOS | 7 |
| RockyLinux |8 |
|Alma Linux|8.3|
|Alpine|3.2|
|Fedora|6|
|Arch Linux|5|

Benchy **may** also works on other distribution than previously stated. Be sure to report any issues that you found.

## Example Output

This is sample output of benchy in action:
```
# # # # # # # # # # # # # # # # # # #
#            Benchy v1.0            #
#   https://github.com/L1so/benchy  #
#        AIO Benchmarking tool      #
# # # # # # # # # # # # # # # # # # #
#       02 Apr 2022 11:06 WIB       #
# # # # # # # # # # # # # # # # # # #

System Information
---------------------
OS          : Ubuntu 18.04.6 LTS
Uptime      : 65 Days, 14 Hours, 46 Minute, 51 Seconds 
Location    : Singapore 
IPv4        : ✔ Enabled
IPv6        : ✔ Enabled

Processor Information
---------------------
Model       : AMD EPYC 7302P 16-Core Processor
Core        : 1 @ 2999.998 MHz
AES-NI      : ✔ Enabled
VM-x/AMD-V  : ✔ Enabled
Virt        : kvm       

Disk & Memory Usage
---------------------
Disk        : 23.55 GiB 
Disk Usage  : 8.56 GiB (39% Used)
Mem         : 985.01 MiB
Mem Usage   : 352 MB (36% Used)
Swap        : 1023.99 MiB

Disk Performance Check (50/50 R/W):
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 194.28 MB/s | 194.79 MB/s | 389.08 MB/s | 48.6k  | 48.7k  | 97.3k  |
+---------------------------------------------------------------------------+
| 64k  | 1.34 GB/s   | 1.35 GB/s   | 2.69 GB/s   | 21.0k  | 21.1k  | 42.1k  |
+---------------------------------------------------------------------------+
| 512k | 1.56 GB/s   | 1.65 GB/s   | 3.22 GB/s   | 3.1k   | 3.2k   | 6.3k   |
+---------------------------------------------------------------------------+
| 1m   | 1.67 GB/s   | 1.78 GB/s   | 3.46 GB/s   | 1.6k   | 1.7k   | 3.4k   |
+---------------------------------------------------------------------------+

Network Performance Test (IPv4):
+---------------------------------------------------------------------------+
| Provider     | Location               | Send            | Receive         |
+===========================================================================+
| Clouvider    | London, UK             | 91.2 Mbits/sec  | 135 Mbits/sec   |
+---------------------------------------------------------------------------+
| Online.net   | Paris, France          | 131 Mbits/sec   | 195 Mbits/sec   |
+---------------------------------------------------------------------------+
| WebHorizon   | Singapore              | 538 Mbits/sec   | 430 Mbits/sec   |
+---------------------------------------------------------------------------+

Network Performance Test (IPv6):
+---------------------------------------------------------------------------+
| Provider     | Location               | Send            | Receive         |
+===========================================================================+
| Clouvider    | London, UK             | 644 Mbits/sec   | 525 Mbits/sec   |
+---------------------------------------------------------------------------+
| Online.net   | Paris, France          | 748 Mbits/sec   | 349 Mbits/sec   |
+---------------------------------------------------------------------------+
| WebHorizon   | Singapore              | 882 Mbits/sec   | 474 Mbits/sec   |
+---------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Type of Test              | Score             |
+===============================================+
| Single Core               | 941               |
+-----------------------------------------------+
| Multi Core                | 918               |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/14026131 |
+-----------------------------------------------+

```
## Feature Request & Bugs
If you ever encounter a bugs, please let me know by opening an issue here. I will try my best to fix them.

Also feel free to submit a feature request, if the idea worth implementing— I'll let you know !