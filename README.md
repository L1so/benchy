# Benchy - Server Benchmarking Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process. [Benchy is known to work across several shells](https://github.com/L1so/benchy#portability).

## Table of Contents
- [Usage](https://github.com/L1so/benchy#usage)
	+ [Normal](https://github.com/L1so/benchy#normal)
	+ [Alias](https://github.com/L1so/benchy#alias)
	+ [Environment Variable](https://github.com/L1so/benchy#environment-variable)
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

### Environment Variable
If you find yourself perform benchmark alot, you may find this feature useful. By default benchy will find if `.benchy_opt` exist on current directory, and will read variable defined there.
1. Download the template.
	```
	wget -qO- benchy.pw | sh -s -- -e
	```
2. [Uncomment any function that you wish to enable.](https://github.com/L1so/benchy/blob/main/.benchy_opt)
3. Run benchy as usual, without any option.
	```
	wget -qO- benchy.pw | sh
	```
	You will see `Found predefined option !` message in your screen.
## Supported flag
```
Usage: benchy [options]
Options:
  -o, --output            Store benchy result to file in given directory (default: Current directory)
  -e, --grab-env          Pull benchy environmental file
  -k, --keep-file         Keep benchy related files after successful run (default: Remove)
  -4, --geekbench4        Utilize ONLY geekbench 4 instead of 5
  -q, --geekbench         Utilize both geekbench 4 and 5
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
#             Benchy v2.1               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        20 Aug 2022 11:59 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                  Hardware Information
---------------------                           ---------------------
OS         : Ubuntu 18.04.6 LTS                 Model       : QEMU Virtual CPU version 2.5+
Location   : Singapore                          Core        : 8 @ 3199.998 MHz
Kernel     : 4.15.0-20-generic                  AES-NI      : ❌ Disabled
Uptime     : 0 days, 0 hrs, 3 mins, 6 secs      VM-x/AMD-V  : ❌ Disabled
Virt       : kvm                                Swap        : 512.0 MiB 

Disk & Memory Usage                             Network Data
---------------------                           ---------------------
Disk       : 118.1 GiB                          ASN         : AS395092  
Disk Usage : 3.7 GiB (4% Used)                  ISP         : Shock Hosting LLC
Mem        : 7.8 GiB                            IPv4        : ✔ Enabled
Mem Usage  : 0.1 GiB (2% Used)                  IPv6        : ✔ Enabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 323.87 MB/s | 324.73 MB/s | 648.61 MB/s | 82.9k  | 83.1k  | 166.0k |
| 64k  | 4.21 GB/s   | 4.23 GB/s   | 8.45 GB/s   | 69.1k  | 69.5k  | 138.6k |
| 512k | 10.20 GB/s  | 10.74 GB/s  | 20.94 GB/s  | 20.9k  | 22.0k  | 42.9k  |
| 1m   | 11.52 GB/s  | 12.28 GB/s  | 23.80 GB/s  | 11.8k  | 12.6k  | 24.4k  |
+---------------------------------------------------------------------------+

Ookla Network Speedtest (Region: Mixed)
+---------------------------------------------------------------------------------------+
| Provider    | Location          | Download     | Upload       | Data Used | Latency   |
+=======================================================================================+
| Biznet      | Jakarta, ID       |  904.4 Mb/s  |  934.7 Mb/s  |    2.0 GB |   11.6 ms |
| Claro       | Montevidio, UY    |  128.6 Mb/s  |  325.7 Mb/s  |    0.7 GB |  369.0 ms |
| CoreIX      | London, GB        |  917.2 Mb/s  |  377.3 Mb/s  |    1.8 GB |  226.1 ms |
| Lightwire   | Hamilton, NZ      |  730.5 Mb/s  |  522.8 Mb/s  |    2.0 GB |  158.2 ms |
| Airstream   | Wisconsin, US     |  397.3 Mb/s  |  397.5 Mb/s  |    1.0 GB |  198.4 ms |
+---------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 862                      |
| Multi Core         | 5954                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/16743117 |
+-----------------------------------------------+
| Benchy time spent  | 5 Minutes 26 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/969OCn |
+-----------------------------------------------+
```

