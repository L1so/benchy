#!/usr/bin/env bash
# Define parameter for arm arch
arch_param="$1"
pkg_param="$2"
# Exit if fail
set -e
# Activate Holy Build Box lib compiliation environment
. /hbb/activate >/dev/null
. /hbb_exe/activate >/dev/null
fail() {
  rm -rf /tmp/dlbin
}
trap fail 0 1 2 3 6 15
# Define user input
case "$arch_param" in
  "arm")
  type="arm-linux-gnueabi"
  c_compiler=/root/armeb-linux-musleabi-cross/bin/armeb-linux-musleabi-gcc
  ddl_link="https://musl.cc/armeb-linux-musleabi-cross.tgz"
  ;;
  "aarch64")
  type="aarch64-linux-gnu"
  c_compiler=/root/aarch64-linux-musl-cross/bin/aarch64-linux-musl-gcc
  ddl_link="https://musl.cc/aarch64-linux-musl-cross.tgz"
  ;;
  "amd64")
  type="x86_64-pc-linux-musl"
  c_compiler=/root/x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc
  ddl_link="https://musl.cc/x86_64-linux-musl-cross.tgz"
  ;;
  "i686")
  type="i686-pc-linux-musl"
  c_compiler="/root/i686-linux-musl-cross/bin/i686-linux-musl-gcc"
  ddl_link="https://musl.cc/i686-linux-musl-cross.tgz"
  ;;
  *) echo "Invalid arch"; exit 1;;
esac

case "$pkg_param" in
  "fio") is_fio="yes";;
  "iperf") is_iperf="yes";;
  "bc") is_bc="yes";;
  "util") is_util="yes";;
  "")
  is_fio="yes"
  is_iperf="yes"
  is_bc="yes"
  is_util="yes"
  ;;
  *) echo "Invalid arg"; exit 1;;
esac

# Confirm
printf "%-11s : %-10s\n" "Type" "$type" "C_Compiler" "$c_compiler" "Link" "$ddl_link"
read -p "Press enter to continue"

# Temp dir to store dl file
tmpdir=/tmp/dlbin
mkdir -p $tmpdir

# Download cross compiler
[ ! -f "$c_compiler" ] && curl -Lo $HOME/musl.tgz $ddl_link && tar -xzf $HOME/musl.tgz -C $HOME
if [ "$is_fio" = "yes" ]; then
  # Download fio
  #1 of 2
  cd $tmpdir
  curl -Lo $tmpdir/libaio.tar.xz https://ftp.debian.org/debian/pool/main/liba/libaio/libaio_0.3.112.orig.tar.xz
  tar -xf $tmpdir/libaio.tar.xz -C $tmpdir
  cd ./libaio-0.3.112 && CC=$c_compiler ENABLE_SHARED=0 LDFLAGS="-static" make prefix=/hbb_exe install
  #2 of 2
  cd $tmpdir
  curl -Lo $tmpdir/fio.tar.gz https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/snapshot/fio-3.30.tar.gz
  tar -xzf $tmpdir/fio.tar.gz -C $tmpdir
  cd ./fio-3.30 && \
  ./configure \
  --cc=$c_compiler \
  --build-static \
  --disable-http && make
  cp fio /tmp/
fi
if [ "$is_iperf" = "yes" ]; then
  # Download iperf3
  curl -Lo $tmpdir/iperf.tar.gz https://downloads.es.net/pub/iperf/iperf-3.11.tar.gz
  tar -xzf $tmpdir/iperf.tar.gz -C $tmpdir
  cd $tmpdir/iperf-3.11 && \
  CC=$c_compiler LDFLAGS="-static" ./configure --enable-static-bin --disable-shared --without-openssl --disable-profiling --build x86_64-pc-linux-gnu --host $type && make
  cp src/iperf3 /tmp/
fi
if [ "$is_bc" = "yes" ]; then
  # Download bc
  cd $tmpdir
  curl -Lo $tmpdir/bc.tar.gz https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz
  tar -xzf $tmpdir/bc.tar.gz -C $tmpdir
  cd ./bc-1.07.1 && \
  CC=$c_compiler LDFLAGS="-static" ./configure --with-readline --build x86_64-pc-linux-gnu --host $type && make
  cp bc/*bc /tmp/bc
fi
if [ "$is_util" = "yes" ]; then
  # Download util-linux
  cd $tmpdir
  curl -Lo $tmpdir/util.tar.gz https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.35/util-linux-2.35.2.tar.gz
  tar -xzf $tmpdir/util.tar.gz -C $tmpdir
  cd ./util-linux-2.35.2
  CC=$c_compiler LDFLAGS=-static CFLAGS=-static SUID_CFLAGS=-static SUID_LDFLAGS=-static CPPFLAGS=-static LDFLAGS=-static \
  ./configure \
  --enable-static \
  --disable-shared \
  --without-python \
  --without-ncurses \
  --without-tinfo \
  --with-udev=/usr/include/libudev.h \
  --build x86_64-pc-linux-gnu \
  --host $type && \
  make lsblk LDFLAGS="--static"
  cp lsblk /tmp/lsblk
fi

# Libcheck
[ -x "/tmp/fio" ] && libcheck /tmp/fio && cp /tmp/fio /io/bin/fio/fio_$type && rm -f /tmp/fio
[ -x "/tmp/iperf3" ] && libcheck /tmp/iperf3 && cp /tmp/bin/iperf/iperf3 /io/iperf_$type && rm -f /tmp/iperf3
[ -x "/tmp/bc" ] && libcheck /tmp/bc && cp /tmp/bc /io/bin/bc/bc_$type && rm -f /tmp/bc
[ -x "/tmp/lsblk" ] && libcheck /tmp/lsblk && cp /tmp/lsblk /io/bin/lsblk/lsblk_$type && rm -f /tmp/lsblk
# Cleaning
rm -rf "$tmpdir"
echo "Done"
