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
# # # # # # # # # # # # # # # # # # # # #
#             Benchy v1.9               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#       26 May 2022 21:10 WIB           #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                            Hardware Information
---------------------                                     ---------------------
Org         : Shock Hosting LLC                           Model       : QEMU Virtual CPU version 2.5+
Location    : Australia                                   Core        : 8 @ 3199.998 MHz
Kernel      : 4.4.0-87-generic                            AES-NI      : ❌ Disabled
Uptime      : 88 Days, 4 Hours, 24 Minute, 20 Seconds     VM-x/AMD-V  : ❌ Disabled
Virt        : kvm                                         Swap        : 512.0 MiB 

Disk & Memory Usage                                       Network Data
---------------------                                     ---------------------
Disk        : 117.7 GiB                                   ASN         : AS395092  
Disk Usage  : 37.6 GiB (32% Used)                         ISP         : Shock Hosting LLC
Mem         : 7.8 GiB                                     IPv4        : ✔ Enabled
Mem Usage   : 1.2 GiB (15% Used)                          IPv6        : ✔ Enabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 222.92 MB/s | 223.50 MB/s | 446.42 MB/s | 57.1k  | 57.2k  | 114.3k |
| 64k  | 2.90 GB/s   | 2.92 GB/s   | 5.83 GB/s   | 47.6k  | 47.9k  | 95.5k  |
| 512k | 5.03 GB/s   | 5.30 GB/s   | 10.33 GB/s  | 10.3k  | 10.8k  | 21.2k  |
| 1m   | 5.17 GB/s   | 5.51 GB/s   | 10.69 GB/s  | 5.3k   | 5.7k   | 10.9k  |
+---------------------------------------------------------------------------+

Network Performance Test (Region: Oceania)
+---------------------------------------------------------------------------------+
| Prot. | Provider    | Location        | Send         | Receive      | Latency   |
+=================================================================================+
| IPv4  | Clouvider   | London, UK      |  306.2 MB/s  |  172.1 MB/s  |  315.6 ms |
|       | Airstream   | Wisconsin, USA  |  428.3 MB/s  |  207.6 MB/s  |  218.1 ms |
|       | Hybula      | Amsterdam, NL   |  681.3 MB/s  |  569.3 MB/s  |  171.3 ms |
|       | Wilhelm.tel | Hamburg, DE     |  549.9 MB/s  |        busy  |    0.0 ms |
+---------------------------------------------------------------------------------+
| IPv6  | Clouvider   | London, UK      |        busy  |  242.6 MB/s  |  216.7 ms |
|       | Airstream   | Wisconsin, USA  |  516.3 MB/s  |  226.0 MB/s  |  225.5 ms |
|       | Hybula      | Amsterdam, NL   |  489.2 MB/s  |  430.2 MB/s  |  227.9 ms |
|       | Wilhelm.tel | Hamburg, DE     |        busy  |        busy  |    0.0 ms |
+---------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 728                      |
| Multi Core         | 4288                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/15134215 |
+-----------------------------------------------+
| Benchy time spent  | 7 Minutes 26 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/i9kToS |
+-----------------------------------------------+
```

