# Benchy - Server Benchmarking Script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script).
## Patron List
* [ReadyDedis](https://readydedis.com) provide a VM with multiple disk to fully accommodate multiple disk bench.
* [jugganuts](https://lowendtalk.com/profile/jugganuts) helps fund the domain name https://benchy.pw.

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
3. Simply execute `benchy` as is-- probably with [option](https://github.com/L1so/benchy#supported-flag).
```bash
	$ benchy -v
	Version  : v2.4
	Revision : 24 Nov 2022
```
### Environment Variable
If you find yourself perform benchmark alot, you may find this feature useful. By default benchy will find if `.benchy_opt` exist on home directory, and will pick variable defined there.
1. [Download the template](https://github.com/L1so/benchy/blob/main/benchy_env).
	```
	wget -O $HOME/.benchy_opt benchy.pw/env
	```
	or
	```
	wget -qO- benchy.pw | sh -s -- -e
	```
2. Uncomment any variable you wish to enable.
3. Run benchy with option `-u` or `--use-env`.
	```
	wget -qO- benchy.pw | sh -s -- -u
	```
	You will see `Found predefined option !` message.
## Supported flag
```
Usage: benchy [options]
Options:
  -o, --output            Store benchy result to file in given directory (default: Current directory)
  -c, --color=ARG         Enable or disable colored output (Valid ARG: yes, no, force)
  -e, --grab-env          Pull benchy environmental file
  -u, --use-env           Use environmental file in place of regular option
  -k, --keep-file         Keep benchy related files after successful run (default: Remove)
  -4, --geekbench4        Utilize ONLY geekbench 4 instead of 5
  -q, --geekbench         Utilize both geekbench 4 and 5
  -j, --json              Store benchy result as json
  -m, --region            Enable region based network test, otherwise will use mixed source
  -n, --skip-network      Skip network measurement test
  -d, --skip-disk         Skip fio disk benchmark test
  -g, --skip-gb           Skip geekbench 5 test
  -r, --region=ARG        Specify region to bench network (Valid ARG: as, af, eu, na, sa, oc, mix)
  -f, --disk=ARG          Specify what disk to bench (e.g. /dev/nvme0np3 or /dev/sda3)
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
* Bench multiple disk at one time
* Ability to pick iperf region
* JSON Output
* Colored Output

## Portability
Below is list of shell which benchy has been tested on.

|Shell|Status|
|---|---|
|Bash|Work without issues|
|Ash|Work without issues|
|Dash|Work without issues|
|ksh|Work without issues|
|mksh|Work without issues|
|zsh|Work without issues|


## Requirement
This section covers various Linux Distribution known to work, each test conducted on clean LXC container.

| Distribution | Minimal Version |fio|iperf3|Geekbench|
| --- | --- |---|---|---|
| Ubuntu | 16.04 |✔️|✔|✔|
|Debian|7|✔|✔|✔|
| CentOS | 7 |✔|✔|✔|
| RockyLinux |8 |✔|✔|✔|
|Alma Linux|8.3|✔|✔|✔|
|Alpine Linux |3.11|✔|✔|❌|
|Fedora|6|✔|✔|✔|
|openSUSE Leap|15.1|✔|✔|✔|
|Arch Linux|2021.12.01|✔️|✔|✔|

**BSD* is not Linux, consequently benchy is not guarranted to work there.

## Example Output

This is sample output of benchy in action:
```
$ wget -qO- benchy.pw | bash -s -- -oks --region=asia
# # # # # # # # # # # # # # # # # # # # #
#             Benchy v2.2               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        03 Nov 2022 19:55 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                  Hardware Information
---------------------                           ---------------------
OS         : Ubuntu 20.04.5 LTS                 Model       : AMD Ryzen 9 5950X 16-Core Processor
Location   : Singapore                          Core        : 8 @ 3393.622 MHz
Kernel     : 5.4.0-131-generic                  AES-NI      : ✔ Enabled
Uptime     : 0 days, 5 hrs, 57 mins, 19 secs    VM-x/AMD-V  : ✔ Enabled
Virt       : kvm                                Swap        : 0.0 KiB   

Disk & Memory Usage                             Network Data
---------------------                           ---------------------
Disk       : 116.1 GiB                          ASN         : AS142594  
Disk Usage : 8.9 GiB (8% Used)                  ISP         : SpeedyPage Ltd
Mem        : 7.7 GiB                            IPv4        : ✔ Enabled
Mem Usage  : 0.9 GiB (12% Used)                 IPv6        : ✔ Enabled

Disk Performance Check (ext4 on /dev/vda1)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 428.78 MB/s | 429.91 MB/s | 858.69 MB/s | 109.8k | 110.0k | 219.8k |
| 64k  | 2.20 GB/s   | 2.21 GB/s   | 4.42 GB/s   | 36.1k  | 36.3k  | 72.5k  |
| 512k | 2.02 GB/s   | 2.13 GB/s   | 4.15 GB/s   | 4.1k   | 4.4k   | 8.5k   |
| 1m   | 2.17 GB/s   | 2.31 GB/s   | 4.48 GB/s   | 2.2k   | 2.4k   | 4.6k   |
+---------------------------------------------------------------------------+

Ookla Network Speedtest (Region: Asia)
+---------------------------------------------------------------------------------------+
| Provider    | Location          | Download     | Upload       | Data Used | Latency   |
+=======================================================================================+
| Biznet      | Jakarta, ID       |  860.9 Mb/s  |  922.9 Mb/s  |    2.5 GB |   12.0 ms |
| Exabytes    | Kuala Lumpur, MY  |  572.2 Mb/s  |  934.2 Mb/s  |    1.8 GB |    8.4 ms |
| SingTel     | Singapore, SG     |  861.1 Mb/s  |  920.2 Mb/s  |    2.1 GB |    1.8 ms |
| GLBB        | Tokyo, JP         |   16.2 Mb/s  |   37.1 Mb/s  |    0.1 GB |   80.5 ms |
| Airtel      | Chennai, IN       |  765.1 Mb/s  |  926.3 Mb/s  |    2.4 GB |   32.8 ms |
+---------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.5 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 1306                     |
| Multi Core         | 7176                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/18406347 |
+-----------------------------------------------+
| Benchy time spent  | 4 Minutes 14 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/SyeE9m |
+-----------------------------------------------+
```
