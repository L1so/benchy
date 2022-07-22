# Benchy - AIO Benchmark Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process. [Benchy is known to work across several shells](https://github.com/L1so/benchy#portability).

## Table of Contents
- [Usage](https://github.com/L1so/benchy#usage)
	+ [Normal](https://github.com/L1so/benchy#normal)
	+ [Alias](https://github.com/L1so/benchy#alias)
- [Feature](https://github.com/L1so/benchy#feature)
- [Supported Flag](https://github.com/L1so/benchy#supported-flag)
- [Portability](https://github.com/L1so/benchy#portability)
- [Requirement](https://github.com/L1so/benchy#requirement)
- [Example Output](https://github.com/L1so/benchy#example-output)

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
  -e, --grab-env          Pull benchy environmental file
  -k, --keep-file         Keep benchy related files after successful run (default: Remove)
  -j, --json              Store benchy result as json
  -m, --region            Enable region based network test, otherwise will use mixed source
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
$ benchy -oks
# # # # # # # # # # # # # # # # # # # # #
#             Benchy v2.0               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        20 Jul 2022 18:59 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                  Hardware Information
---------------------                           ---------------------
OS         : Ubuntu 14.04.6 LTS                 Model       : QEMU Virtual CPU version 2.5+
Location   : Indonesia                          Core        : 4 @ 2199.998 MHz
Kernel     : 4.4.0-93-generic                   AES-NI      : ❌ Disabled
Uptime     : 20 days, 18 hrs, 58 mins, 29 secs  VM-x/AMD-V  : ❌ Disabled
Virt       : none                               Swap        : 4.0 GiB   

Disk & Memory Usage                             Network Data
---------------------                           ---------------------
Disk       : 45.2 GiB                           ASN         : AS140389  
Disk Usage : 9.4 GiB (23% Used)                 ISP         : PT Dewa Bisnis Digital
Mem        : 7.8 GiB                            IPv4        : ✔ Enabled
Mem Usage  : 2.8 GiB (36% Used)                 IPv6        : ❌ Disabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 23.21 MB/s  | 23.22 MB/s  | 46.44 MB/s  | 5.9k   | 5.9k   | 11.9k  |
| 64k  | 325.82 MB/s | 327.54 MB/s | 653.37 MB/s | 5.2k   | 5.2k   | 10.4k  |
| 512k | 0.99 GB/s   | 1.04 GB/s   | 2.03 GB/s   | 2.0k   | 2.1k   | 4.2k   |
| 1m   | 1.04 GB/s   | 1.11 GB/s   | 2.16 GB/s   | 1.1k   | 1.1k   | 2.2k   |
+---------------------------------------------------------------------------+

Ookla Network Speedtest (Region: Asia)
+---------------------------------------------------------------------------------------+
| Provider    | Location          | Download     | Upload       | Data Used | Latency   |
+=======================================================================================+
| Biznet      | Jakarta, ID       |  813.3 MB/s  |  682.9 MB/s  |    1.7 GB |    1.3 ms |
| Exabytes    | Kuala Lumpur, MY  |  192.4 MB/s  |  165.5 MB/s  |    0.5 GB |   19.3 ms |
| SingTel     | Singapore, SG     |  388.7 MB/s  |  216.8 MB/s  |    0.6 GB |   14.2 ms |
| GLBB        | Tokyo, JP         |  216.5 MB/s  |  136.5 MB/s  |    0.5 GB |   78.6 ms |
| Airtel      | Chennai, IN       |  329.6 MB/s  |  150.3 MB/s  |    0.6 GB |   44.3 ms |
+---------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 496                      |
| Multi Core         | 1728                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/16123617 |
+-----------------------------------------------+
| Benchy time spent  | 6 Minutes 29 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/Ef6Uio |
+-----------------------------------------------+
```

