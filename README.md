# Benchy - AIO Benchmark script

Benchy is a fork of MasonR's [Yet Another Bench Script (YABS)](https://github.com/masonr/yet-another-bench-script), some of Benchy code used same technique as YABS do— I have rewritten some of snippets to optimize the process.

## Supported flag
```
Usage: benchy [options]
Options:
  -t, --temp-file         Remove benchy dependencies after run (default: keep storing)
  -n, --skip-network      Skip iperf3 network measurement test
  -d, --skip-disk         Skip fio disk benchmark test
  -g, --skip-gb           Skip geekbench 5 test
  -i, --show-ip           Display server public IP address
  -l, --long-info         Display long complete output
  -p, --parse-only        Only parse basic information (equal to -ndg)
  -h, --help              Display this help section
  -v, --version           Display version
```

## Usage
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
* Support for multiple disk layout

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
#            Benchy v1.3            #
#   https://github.com/L1so/benchy  #
#        AIO Benchmarking tool      #
# # # # # # # # # # # # # # # # # # #
#       24 Apr 2022 17:28 WIB       #
# # # # # # # # # # # # # # # # # # #

System Information
---------------------
OS          : Ubuntu 18.04.6 LTS
Uptime      : 3 Days, 1 Hours, 48 Minute, 34 Seconds 
Location    : Indonesia 
IPv4        : ✔ Enabled
IPv6        : ✔ Enabled

Processor Information
---------------------
Model       : QEMU Virtual CPU version 2.5+
Core        : 1 @ 3199.998 MHz
AES-NI      : ❌ Disabled
VM-x/AMD-V  : ❌ Disabled
Virt        : kvm       

Disk & Memory Usage
---------------------
Disk        : 29.49 GiB 
Disk Usage  : 8.64 GiB (31% Used)
Mem         : 1.94 GiB  
Mem Usage   : 384 MB (19% Used)
Swap        : 511.99 MiB

Disk Performance Check (ext4 on /dev/vda1):
+---------------------------------------------------------------------------+
| Size | Read        | Write       | Total       |       IOPS (R,W,T)       |
+===========================================================================+
| 4k   | 250.09 MB/s | 250.75 MB/s | 500.85 MB/s | 64.0k  | 64.2k  | 128.2k |
| 64k  | 2.91 GB/s   | 2.93 GB/s   | 5.85 GB/s   | 47.9k  | 48.1k  | 96.0k  |
| 512k | 6.69 GB/s   | 7.04 GB/s   | 13.74 GB/s  | 13.7k  | 14.4k  | 28.1k  |
| 1m   | 7.58 GB/s   | 8.09 GB/s   | 15.68 GB/s  | 7.8k   | 8.3k   | 16.1k  |
+---------------------------------------------------------------------------+

Network Performance Test:
+--------------------------------------------------------------------------------------+
| Prot. | Provider    | Location        | Send            | Receive         | Latency  |
+======================================================================================+
| IPv4  | Clouvider   | London, UK      | 483 Mbits/sec   | 146 Mbits/sec   | 222 ms   |
|       | Airstream   | Wisconsin, USA  | 485 Mbits/sec   | 155 Mbits/sec   | 228 ms   |
|       | Uztelecom   | Tashkent, UZB   | 567 Mbits/sec   | 189 Mbits/sec   | 246 ms   |
|       | Online.net  | Paris, FRA      | 739 Mbits/sec   | 247 Mbits/sec   | 173 ms   |
|       | WebHorizon  | Singapore, SG   | busy            | busy            | busy     |
+--------------------------------------------------------------------------------------+
| IPv6  | Clouvider   | London, UK      | 500 Mbits/sec   | 170 Mbits/sec   | 221 ms   |
|       | Airstream   | Wisconsin, USA  | 447 Mbits/sec   | 101 Mbits/sec   | 230 ms   |
|       | Uztelecom   | Tashkent, UZ    | 435 Mbits/sec   | 171 Mbits/sec   | 238 ms   |
|       | Online.net  | Paris, FR       | 753 Mbits/sec   | 115 Mbits/sec   | 165 ms   |
|       | WebHorizon  | Singapore, SG   | busy            | busy            | busy     |
+--------------------------------------------------------------------------------------+

+-----------------------------------------------+
| Geekbench 5.4.4 Tryout for Linux x86 (64-bit) |
+===============================================+
| Single Core        | 863                      |
| Multi Core         | 848                      |
+-----------------------------------------------+
| https://browser.geekbench.com/v5/cpu/14520333 |
+-----------------------------------------------+
| Benchy time spent  | 9 Minutes 49 Seconds     |
+-----------------------------------------------+

```

