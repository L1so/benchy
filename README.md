# Benchy - AIO Benchmark Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process. [Benchy is known to work across several shells](https://github.com/L1so/benchy#portability).

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
2. Source the file then (e.g. `. ~/.bashrc` or `. ~/.bash_aliases`).
3. You can now painlessly perform benchmark without typing long command. Be sure to check available option on [Supported Flag](https://github.com/L1so/benchy#supported-flag)
	
		$ benchy -v
		v2.0


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
|Arch Linux|2021.12.01|✔️|✔|✔|

Benchy **may** also works on other distribution than previously stated. Be sure to report any issues that you found.

## Example Output

This is sample output of benchy in action:
```
$ benchy -okjs
# # # # # # # # # # # # # # # # # # # # #
#             Benchy v2.0               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        14 Jul 2022 14:50 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                  Hardware Information
---------------------                           ---------------------
OS         : Ubuntu 18.04 LTS                   Model       : AMD EPYC 7402P 24-Core Processor
Location   : Australia                          Core        : 2 @ 2794.748 MHz
Kernel     : 4.15.0-22-generic                  AES-NI      : ✔ Enabled
Uptime     : 44 days, 5 hrs, 41 mins, 53 secs   VM-x/AMD-V  : ✔ Enabled
Virt       : kvm                                Swap        : 0.0 KiB   

Disk & Memory Usage                             Network Data
---------------------                           ---------------------
Disk       : 78.7 GiB                           ASN         : AS136557  
Disk Usage : 8.8 GiB (12% Used)                 ISP         : Host Universal Pty Ltd
Mem        : 3.9 GiB                            IPv4        : ✔ Enabled
Mem Usage  : 1.4 GiB (36% Used)                 IPv6        : ❌ Disabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 265.34 MB/s | 266.04 MB/s | 531.39 MB/s | 67.9k  | 68.1k  | 136.0k |
| 64k  | 2.14 GB/s   | 2.15 GB/s   | 4.29 GB/s   | 35.1k  | 35.3k  | 70.4k  |
| 512k | 3.71 GB/s   | 3.90 GB/s   | 7.61 GB/s   | 7.6k   | 8.0k   | 15.6k  |
| 1m   | 4.04 GB/s   | 4.31 GB/s   | 8.36 GB/s   | 4.1k   | 4.4k   | 8.6k   |
+---------------------------------------------------------------------------+

Ookla Network Speedtest (Region: Oceania)
+---------------------------------------------------------------------------------------+
| Provider    | Location          | Download     | Upload       | Data Used | Latency   |
+=======================================================================================+
| Vocus       | Perth, AU         |  903.4 MB/s  |  746.6 MB/s  |    2.0 GB |   47.4 ms |
| Telstra     | Sydney, AU        |  949.9 MB/s  |  822.9 MB/s  |    2.6 GB |   99.6 ms |
| MyRepublic  | Auckland, NZ      |  950.0 MB/s  |  658.4 MB/s  |    2.3 GB |  122.0 ms |
| Lightwire   | Hamilton, NZ      |  945.5 MB/s  |  669.5 MB/s  |    2.4 GB |  122.4 ms |
| Vodafone    | Melbourne, AU     | Failed       | To           | Get       | Data      |
+---------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 947                      |
| Multi Core         | 1869                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/16003640 |
+-----------------------------------------------+
| Benchy time spent  | 4 Minutes 12 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/EYt7DP |
+-----------------------------------------------+
```

