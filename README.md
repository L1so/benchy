# Benchy - AIO Benchmark script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process.

## Supported option
	Usage: benchy [options]
	Options:
	  -t, --temp-file         Remove benchy dependencies after run (default: keep storing)
	  -n, --skip-network      Skip iperf3 network measurement test
	  -d, --skip-disk         Skip fio disk benchmark test
	  -g, --skip-gb           Skip geekbench 5 test
	  -i, --show-ip           Display server public IP address
	  -l, --long-info         Display long complete output
	  -p, --parse-only        Only parse basic information (equal to -tndg)
	  -h, --help              Display this help section
	  -v, --version           Display version

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

## Alpine Linux
While most Linux distribution uses glibc, Alpine Linux implement [musl libc](https://musl.libc.org/) in its system, below is non-exhaustive list to what's known **not** to work in Musl based system.

- ~~fio~~ (Work as of v1.1)
- ~~iperf3~~ (Work as of v1.1)
- Geekbench
## Example Output

This is sample output of benchy in action:
```
# # # # # # # # # # # # # # # # # # #
#            Benchy v1.2            #
#   https://github.com/L1so/benchy  #
#        AIO Benchmarking tool      #
# # # # # # # # # # # # # # # # # # #
#       18 Apr 2022 17:00 WIB       #
# # # # # # # # # # # # # # # # # # #

Server Information
---------------------
OS          : Ubuntu 16.04.7 LTS
Uptime      : 22 Days, 0 Hours, 12 Minute, 21 Seconds 
Location    : Singapore 
CPU         : AMD EPYC 7502P 32-Core Processor
Core        : 2 @ 2495.312 MHz
AES-NI      : ✔ Enabled
VM-x/AMD-V  : ✔ Enabled
Virt        : kvm       

Disk & Memory Usage
---------------------
Disk        : 49.18 GiB 
Disk Usage  : 18.29 GiB (40% Used)
Mem         : 3.85 GiB  
Mem Usage   : 318 MB (8% Used)
Swap        : 1023.99 MiB

Disk Performance Check (ext4 on /dev/vda1):
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 305.77 MB/s | 306.57 MB/s | 612.34 MB/s | 78.3k  | 78.5k  | 156.8k |
| 64k  | 1.12 GB/s   | 1.13 GB/s   | 2.25 GB/s   | 18.4k  | 18.5k  | 37.0k  |
| 512k | 1.08 GB/s   | 1.14 GB/s   | 2.22 GB/s   | 2.2k   | 2.3k   | 4.6k   |
| 1m   | 1.02 GB/s   | 1.09 GB/s   | 2.11 GB/s   | 1.0k   | 1.1k   | 2.2k   |
+---------------------------------------------------------------------------+

Network Performance Test:
+--------------------------------------------------------------------------------------+
| Prot. | Provider    | Location        | Send            | Receive         | Latency  |
+======================================================================================+
| IPv4  | Clouvider   | London, UK      | 769 Mbits/sec   | 718 Mbits/sec   | 166 ms   |
|       | Airstream   | Wisconsin, USA  | 214 Mbits/sec   | 438 Mbits/sec   | 262 ms   |
|       | Uztelecom   | Tashkent, UZB   | 454 Mbits/sec   | 577 Mbits/sec   | 216 ms   |
|       | Online.net  | Paris, FRA      | 1.08 Gbits/sec  | 877 Mbits/sec   | 156 ms   |
|       | WebHorizon  | Singapore, SG   | 954 Mbits/sec   | 494 Mbits/sec   | 1 ms     |
+--------------------------------------------------------------------------------------+
| IPv6  | Clouvider   | London, UK      | 769 Mbits/sec   | 717 Mbits/sec   | 169 ms   |
|       | Airstream   | Wisconsin, USA  | 522 Mbits/sec   | 531 Mbits/sec   | 227 ms   |
|       | Uztelecom   | Tashkent, UZ    | 529 Mbits/sec   | 504 Mbits/sec   | 236 ms   |
|       | Online.net  | Paris, FR       | 632 Mbits/sec   | 524 Mbits/sec   | 247 ms   |
|       | WebHorizon  | Singapore, SG   | 940 Mbits/sec   | 479 Mbits/sec   | 2 ms     |
+--------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core               | 912               |
| Multi Core                | 1776              |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/14391593 |
+-----------------------------------------------+

```

