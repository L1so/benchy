# Benchy - AIO Benchmark Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process.

## Supported flag
```
Usage: benchy [options]
Options:
  -o, --output            Store benchy result to file in given directory (default: Current directory)
  -k, --keep-file         Keep benchy related files after successful run (default: Remove)
  -j, --json              Store benchy result as json
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
### Normal
Via wget.

	wget -qO- benchy.pw | sh
Via curl.

	curl -Ls benchy.pw | sh
### Alias
1. Add following command to your `.bashrc` or `.bash_aliases`.
	- wget.
	
			benchy() { wget -qO- benchy.pw | sh -s -- "$@"; }
	- curl.
	
			benchy() { curl -Ls benchy.pw | sh -s -- "$@"; }
2. Source the file then (e.g. `source ~/.bashrc` or `source ~/.bash_aliases`).
3. You can now painlessly perform benchmark without typing long command. Be sure to check available option on [Supported Flag](https://github.com/L1so/benchy#supported-flag)
	
		$ benchy -v
		v2.0

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
* JSON Output

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
#             Benchy v2.0               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        12 Jul 2022 18:34 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                         Hardware Information
---------------------                                  ---------------------
OS         : Ubuntu 16.04.7 LTS                        Model       : AMD Ryzen 9 5950X 16-Core Processor
Location   : Singapore                                 Core        : 2 @ 3393.622 MHz
Kernel     : 4.4.0-122-generic                         AES-NI      : ✔ Enabled
Uptime     : 133 Days, 12 Hours, 25 Minute, 21 Seconds VM-x/AMD-V  : ✔ Enabled
Virt       : kvm                                       Swap        : 3.0 GiB   

Disk & Memory Usage                                    Network Data
---------------------                                  ---------------------
Disk       : 34.4 GiB                                  ASN         : AS59253   
Disk Usage : 16.3 GiB (50% Used)                       ISP         : Leaseweb Asia Pacific pte. ltd.
Mem        : 2.9 GiB                                   IPv4        : ✔ Enabled
Mem Usage  : 0.5 GiB (16% Used)                        IPv6        : ✔ Enabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 421.53 MB/s | 422.64 MB/s | 844.18 MB/s | 107.9k | 108.2k | 216.1k |
| 64k  | 1.33 GB/s   | 1.33 GB/s   | 2.66 GB/s   | 21.8k  | 21.9k  | 43.7k  |
| 512k | 2.05 GB/s   | 2.15 GB/s   | 4.20 GB/s   | 4.2k   | 4.4k   | 8.6k   |
| 1m   | 1.95 GB/s   | 2.08 GB/s   | 4.04 GB/s   | 2.0k   | 2.1k   | 4.1k   |
+---------------------------------------------------------------------------+

Network Performance Test (Region: Asia)
+---------------------------------------------------------------------------------+
| Prot. | Provider    | Location        | Send         | Receive      | Latency   |
+=================================================================================+
| IPv4  | Uztelecom   | Tashkent, UZ    |  866.1 MB/s  |  852.3 MB/s  |  179.3 ms |
|       | Biznet      | Jakarta, ID     |    3.3 GB/s  |    4.0 GB/s  |   15.8 ms |
+---------------------------------------------------------------------------------+
| IPv6  | Uztelecom   | Tashkent, UZ    |  877.3 MB/s  |  777.0 MB/s  |  186.2 ms |
|       | Biznet      | Jakarta, ID     |        busy  |        busy  |    0.0 ms |
+---------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 1277                     |
| Multi Core         | 2307                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/15967649 |
+-----------------------------------------------+
| Benchy time spent  | 4 Minutes 23 Seconds     |
+-----------------------------------------------+


```

