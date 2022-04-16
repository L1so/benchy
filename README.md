# Benchy - AIO Benchmark script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to make it more efficient.

## Download
Via wget.

	wget -qO- https://raw.githubusercontent.com/L1so/benchy/main/benchy | sh
Via curl.

	curl -Ls https://raw.githubusercontent.com/L1so/benchy/main/benchy | sh
## Feature
* Basic server information, this include but not limited to:
	* Operating System
	* CPU Model
	* CPU Core Count
	* Virtualization used
	* Disk (Count and Usage)
	* Memory (Count and Usage)
	* Swap size
* IPv4 Check
* IPv6 Check
* Server Geolocation
* Server Uptime
* Fallback to `wget` if `curl` is not installed (this applied to Debian based system, where `curl` is not installed by default)
* [POSIX](https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/) compliant, meaning in theory it should work on all platform that enforce POSIX. <sub>See [Portability](https://github.com/L1so/benchy#portability)</sub>

## Portability
As of [fca1b99](https://github.com/L1so/benchy/commit/fca1b99b8fabeb563a8e6a628b82b4634e03b0f8), I have removed all [bashism](https://mywiki.wooledge.org/Bashism) from Benchy code and replace them with their POSIX counterpart. This of course to ensure portability between different kind of shells.

Benchy should work on all POSIX shells (e.g. `dash`, `ksh`, `zsh`, `mksh`, `ash`). Though I only have tested and confirm working on `dash` and `ksh`.

## Requirement
This section covers various Linux Distribution supported by benchy, each test conducted on clean LXC container.

| Distribution | Minimal Version |Fully Tested ?|
| --- | --- |---|
| Ubuntu | 14.04 |Yes|
|Debian|7|Yes|
| CentOS | 7 |Yes|
| RockyLinux |8 |Yes|
|Alma Linux|8.3|Yes|
|Alpine Linux |3.11|Yes <sub><sup>With [note](https://github.com/L1so/benchy#alpine-linux)</sup></sub>|
|Fedora|6|Yes|

Benchy **may** also works on other distribution than previously stated. Be sure to report any issues that you found.

## Alpine Linux
<strike>While most Linux distribution uses glibc, Alpine Linux implement [musl libc](https://musl.libc.org/) in its system, thus making precompiled binaries not working as it is not compatible with musl libc.

Until I have found a way to correctly create a precompiled binaries that works across library, Alpine Linux user are advised to install three core package of benchy.

	apk add ncurses # tput
	apk add fio # fio
	apk add iperf3 # iperf3
Also I have confirmed that geekbench **does not work** with alpine, once again this is due to incompatible c library.
</strike>

With the exception of geekbench, now those precompiled binaries will works on Alpine Linux (musl libc).
## Example Output

This is sample output of benchy in action:
```
# # # # # # # # # # # # # # # # # # #
#            Benchy v1.2            #
#   https://github.com/L1so/benchy  #
#        AIO Benchmarking tool      #
# # # # # # # # # # # # # # # # # # #
#       16 Apr 2022 15:25 WIB       #
# # # # # # # # # # # # # # # # # # #

Server Information
---------------------
OS          : Ubuntu 16.04.7 LTS
Uptime      : 19 Days, 22 Hours, 37 Minute, 34 Seconds 
Location    : Singapore 
CPU         : AMD EPYC 7502P 32-Core Processor
Core        : 2 @ 2495.312 MHz
AES-NI      : ✔ Enabled
VM-x/AMD-V  : ✔ Enabled
Virt        : kvm       

Disk & Memory Usage
---------------------
Disk        : 49.18 GiB 
Disk Usage  : 18.30 GiB (40% Used)
Mem         : 3.85 GiB  
Mem Usage   : 421 MB (11% Used)
Swap        : 1023.99 MiB

Disk Performance Check (ext4 on /dev/vda1):
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 313.69 MB/s | 314.52 MB/s | 628.22 MB/s | 80.3k  | 80.5k  | 160.8k |
| 64k  | 1.08 GB/s   | 1.08 GB/s   | 2.17 GB/s   | 17.8k  | 17.9k  | 35.6k  |
| 512k | 1.03 GB/s   | 1.09 GB/s   | 2.13 GB/s   | 2.1k   | 2.2k   | 4.4k   |
| 1m   | 1.08 GB/s   | 1.15 GB/s   | 2.24 GB/s   | 1.1k   | 1.2k   | 2.3k   |
+---------------------------------------------------------------------------+

Network Performance Test:
+-------------------------------------------------------------------------------------------+
| Prot. | Provider    | Location             | Send            | Receive         | Latency  |
+===========================================================================================+
| IPv4  | Clouvider   | London, UK           | 767 Mbits/sec   | 721 Mbits/sec   | 169 ms   |
|       | Airstream   | Wisconsin, USA       | 272 Mbits/sec   | 540 Mbits/sec   | 234 ms   |
|       | Uztelecom   | Tashkent, UZB        | 716 Mbits/sec   | 588 Mbits/sec   | 215 ms   |
|       | Online.net  | Paris, FRA           | 1.06 Gbits/sec  | 838 Mbits/sec   | 156 ms   |
|       | WebHorizon  | Singapore, SG        | 954 Mbits/sec   | 494 Mbits/sec   | 1 ms     |
+-------------------------------------------------------------------------------------------+
| IPv6  | Clouvider   | London, UK           | 766 Mbits/sec   | 719 Mbits/sec   | 169 ms   |
|       | Airstream   | Wisconsin, USA       | 520 Mbits/sec   | 524 Mbits/sec   | 227 ms   |
|       | Uztelecom   | Tashkent, UZ         | 612 Mbits/sec   | 526 Mbits/sec   | 236 ms   |
|       | Online.net  | Paris, FR            | 612 Mbits/sec   | 523 Mbits/sec   | 247 ms   |
|       | WebHorizon  | Singapore, SG        | 939 Mbits/sec   | 480 Mbits/sec   | 2 ms     |
+-------------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+-----------------------------------------------+
| Type of Test              | Score             |
+===============================================+
| Single Core               | 904               |
| Multi Core                | 1766              |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/14348398 |
+-----------------------------------------------+


```
## Feature Request & Bugs
If you ever encounter a bugs, please let me know by opening an issue here. I will try my best to fix them.

Also feel free to submit a feature request, if the idea worth implementing— I'll let you know !
