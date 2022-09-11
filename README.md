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
		v2.2

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
* Bench multiple disk at one time
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
$ wget -qO- benchy.pw | bash -s -- -oks
# # # # # # # # # # # # # # # # # # # # #
#             Benchy v2.2               #
#    https://github.com/L1so/benchy     #
# # # # # # # # # # # # # # # # # # # # #
#        10 Sep 2022 14:16 WIB          #
# # # # # # # # # # # # # # # # # # # # #

Server Insight                                  Hardware Information
---------------------                           ---------------------
OS         : Ubuntu 18.04 LTS                   Model       : Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz
Location   : Singapore                          Core        : 2 @ 2199.944 MHz
Kernel     : 4.15.0-192-generic                 AES-NI      : ✔ Enabled
Uptime     : 0 days, 0 hrs, 0 mins, 59 secs     VM-x/AMD-V  : ✔ Enabled
Virt       : kvm                                Swap        : 2.0 GiB   

Disk & Memory Usage                             Network Data
---------------------                           ---------------------
Disk       : 32.4 GiB                           ASN         : AS59253   
Disk Usage : 5.9 GiB (20% Used)                 ISP         : Leaseweb Asia Pacific pte. ltd.
Mem        : 3.9 GiB                            IPv4        : ✔ Enabled
Mem Usage  : 0.2 GiB (5% Used)                  IPv6        : ❌ Disabled

Disk Performance Check (ext4 on /dev/vda2)
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 88.89 MB/s  | 89.12 MB/s  | 178.01 MB/s | 22.8k  | 22.8k  | 45.6k  |
| 64k  | 1.10 GB/s   | 1.11 GB/s   | 2.21 GB/s   | 18.1k  | 18.2k  | 36.4k  |
| 512k | 1.45 GB/s   | 1.53 GB/s   | 2.98 GB/s   | 3.0k   | 3.1k   | 6.1k   |
| 1m   | 1.68 GB/s   | 1.79 GB/s   | 3.48 GB/s   | 1.7k   | 1.8k   | 3.6k   |
+---------------------------------------------------------------------------+

Ookla Network Speedtest (Region: Mixed)
+---------------------------------------------------------------------------------------+
| Provider    | Location          | Download     | Upload       | Data Used | Latency   |
+=======================================================================================+
| Biznet      | Jakarta, ID       |    5.8 Gb/s  |    5.1 Gb/s  |   13.5 GB |   14.5 ms |
| Claro       | Montevidio, UY    |    1.0 Gb/s  |  269.6 Mb/s  |    1.5 GB |  374.6 ms |
| CoreIX      | London, GB        |  941.4 Mb/s  |  540.7 Mb/s  |    2.4 GB |  162.6 ms |
| Lightwire   | Hamilton, NZ      |    1.5 Gb/s  |  386.6 Mb/s  |    2.9 GB |  155.5 ms |
| Airstream   | Wisconsin, US     |    3.0 Gb/s  |  177.6 Mb/s  |    4.3 GB |  238.0 ms |
+---------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.5 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 657                      |
| Multi Core         | 1281                     |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/17169101 |
+-----------------------------------------------+
| Benchy time spent  | 5 Minutes 57 Seconds     |
+-----------------------------------------------+
| Benchy result      | http://sprunge.us/onOHJj |
+-----------------------------------------------+
```

