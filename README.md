# Benchy - AIO Benchmark Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process.

## Supported flag
```
Usage: benchy [options]
Options:
  -o, --output            Store benchy result to file in given directory (default: Current directory)
  -t, --temp-file         Remove benchy dependencies after run (default: keep storing)
  -n, --skip-network      Skip network measurement test
  -d, --skip-disk         Skip fio disk benchmark test
  -g, --skip-gb           Skip geekbench 5 test
  -r, --region=ARG        Specify region to bench network (as, af, eu, na, sa, oc, mix)
  -s, --speedtest         Prefer speedtest in place of iperf3
  -i, --show-ip           Display server public IP address
  -l, --long-info         Display long complete output
  -p, --parse-only        Only parse basic information (equal to -ndg)
  -h, --help              Display this help section
  -v, --version           Display version
```

## Usage
Via wget.

	wget -qO- benchy.pw | sh
Via curl.

	curl -Ls benchy.pw | sh
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
* Support for multiple disk layout
* Ability to pick iperf region

## Portability
As of [fca1b99](https://github.com/L1so/benchy/commit/fca1b99b8fabeb563a8e6a628b82b4634e03b0f8), I have removed all [bashism](https://mywiki.wooledge.org/Bashism) from Benchy code and replace them with their POSIX counterpart. This of course to ensure portability between different kind of shells.

Benchy should work on all POSIX shells (e.g. `dash`, `ksh`, `zsh`, `mksh`, `ash`). Though I only have tested and confirm working on `dash` and `ksh`.

## Requirement
This section covers various Linux Distribution supported by benchy, each test conducted on clean LXC container.

| Distribution | Minimal Version |fio|iperf3|Geekbench|
| --- | --- |---|---|---|
| Ubuntu | 14.04 |✔️|✔|✔|
|Debian|7|✔|✔|✔|
| CentOS | 7 |✔|✔|✔|
| RockyLinux |8 |✔|✔|✔|
|Alma Linux|8.3|✔|✔|✔|
|Alpine Linux |3.11|✔|✔|❌|
|Fedora|6|✔|✔|✔|
|openSUSE Leap|15.1|✔|✔|✔|

Benchy **may** also works on other distribution than previously stated. Be sure to report any issues that you found.

## Example Output

This is sample output of benchy in action:
```
# # # # # # # # # # # # # # # # # # #
#            Benchy v1.5            #
#   https://github.com/L1so/benchy  #
#        AIO Benchmarking tool      #
# # # # # # # # # # # # # # # # # # #
#      29 Apr 2022 20:59 WIB        #
# # # # # # # # # # # # # # # # # # #

Server Information
---------------------
OS          : Ubuntu 18.04.6 LTS
Uptime      : 1 Days, 8 Hours, 45 Minute, 13 Seconds 
Location    : Singapore 
CPU         : AMD EPYC 7302P 16-Core Processor
Core        : 1 @ 2999.998 MHz
AES-NI      : ✔ Enabled
VM-x/AMD-V  : ✔ Enabled
Virt        : kvm       

Disk & Memory Usage
---------------------
Disk        : 23.55 GiB 
Disk Usage  : 9.92 GiB (45% Used)
Mem         : 985.01 MiB
Mem Usage   : 117 MB (12% Used)
Swap        : 1023.99 MiB

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 173.25 MB/s | 173.71 MB/s | 346.97 MB/s | 44.4k  | 44.5k  | 88.8k  |
| 64k  | 609.01 MB/s | 612.21 MB/s | 1.19 GB/s   | 9.7k   | 9.8k   | 19.5k  |
| 512k | 660.81 MB/s | 695.92 MB/s | 1.32 GB/s   | 1.3k   | 1.4k   | 2.7k   |
| 1m   | 673.91 MB/s | 718.80 MB/s | 1.35 GB/s   | 0.7k   | 0.7k   | 1.4k   |
+---------------------------------------------------------------------------+

Network Performance Test (Region: Mixed)
+--------------------------------------------------------------------------------------+
| Prot. | Provider    | Location        | Send            | Receive         | Latency  |
+======================================================================================+
| IPv4  | Clouvider   | London, UK      | 113 Mbits/sec   | 147 Mbits/sec   | 155 ms   |
|       | Airstream   | Wisconsin, USA  | 68.5 Mbits/sec  | 127 Mbits/sec   | 232 ms   |
|       | Hybula      | Amsterdam, NL   | busy            | busy            | 159 ms   |
|       | Online.net  | Paris, FRA      | 93.9 Mbits/sec  | 123 Mbits/sec   | 150 ms   |
+--------------------------------------------------------------------------------------+
| IPv6  | Clouvider   | London, UK      | 694 Mbits/sec   | 493 Mbits/sec   | 155 ms   |
|       | Airstream   | Wisconsin, USA  | 466 Mbits/sec   | 303 Mbits/sec   | 232 ms   |
|       | Hybula      | Amsterdam, NL   | busy            | busy            | 159 ms   |
|       | Online.net  | Paris, FRA      | busy            | busy            | busy     |
+--------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 942                      |
| Multi Core         | 946                      |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/14619307 |
+-----------------------------------------------+
| Benchy time spent  | 7 Minutes 37 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/5pTIsC |
+-----------------------------------------------+
```

