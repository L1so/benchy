#!/bin/bash
set -e

# Activate Holy Build Box lib compiliation environment
source /hbb/activate

set -x

# Determine architecture
arch=$(uname -m)
case "$arch" in
  *x86_64*) arch="x64";;
  *i?86*) arch="x86";;
  *) printf "Architecture not found\n"; exit 1;;
esac

# Install ncurses
curl -L https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.1.tar.gz -o "ncurses.tar.gz"
tar -xzf ./ncurses.tar.gz
cd ncurses-*
env CFLAGS="$STATICLIB_CFLAGS" CXXFLAGS="$STATICLIB_CXXFLAGS" ./configure --prefix=/hbb_exe --enable-static && \
make && \
make install
[ $? -eq 0 ] && cp /hbb_exe/bin/tput /tmp
# Install texinfo
yum --disablerepo=phusion_centos-6-scl-i386,phusion_centos-6-scl-i386-source -y install texinfo

# Activate Holy Build Box environment.
source /hbb_exe/activate

# GNU bc
curl -L http://alpha.gnu.org/gnu/bc/bc-1.06.95.tar.bz2 -o "bc.tar.bz"
tar -xjf ./bc.tar.bz
cd bc-*

# Compile
./configure --with-readline --prefix=/tmp && \
make && \
make install

# GNU screen
curl -L https://ftp.gnu.org/gnu/screen/screen-4.4.0.tar.gz -o "screen.tar.gz"
tar -xzf ./screen.tar.gz
cd screen-*

# Compile
./configure --enable-colors256 --with-sys-screenrc=/etc/screenrc --prefix=/tmp && \
make && \
make install

# Verifying result
libcheck /tmp/bin/bc
libcheck /tmp/bin/dc
libcheck /tmp/bin/screen
libcheck /tmp/tput

# Copy result to host
cp /tmp/bin/bc /io/bc_$arch
cp /tmp/bin/screen /io/screen_$arch
cp /tmp/tput /io/tput_$arch
