Return-Path: <chrispl78@yahoo.com>
Received: from web58102.mail.re3.yahoo.com (web58102.mail.re3.yahoo.com
	[68.142.236.125]) by ozlabs.org (Postfix) with SMTP id DF528DDF85
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 12:57:18 +1000 (EST)
Message-ID: <407093.53240.qm@web58102.mail.re3.yahoo.com>
Date: Wed, 6 May 2009 19:50:37 -0700 (PDT)
From: Chris Plasun <chrispl78@yahoo.com>
Subject: Trouble using with Kegel cross tool chain
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm getting a bit desperate trying to build a  gcc / glibc cross-toolchainfor 
use on a Freescale MPC8313 but am having problems.

I follow the Quick Start instructions at 
http://www.kegel.com/crosstool/crosstool-0.43/doc/crosstool-howto.html and 
run demo-powerpc-603.sh (is that the correct script for the MPC8313?)

I check the /opt/crosstool directory and there is nothing there.

Below are the results of running the above script:

=================
 
linux-66oa:~/work/crosstool-0.43 # sh demo-powerpc-603.sh 
+ TARBALLS_DIR=/root/downloads
+ RESULT_TOP=/opt/crosstool
+ export TARBALLS_DIR RESULT_TOP
+ GCC_LANGUAGES=c,c++
+ export GCC_LANGUAGES
+ mkdir -p /opt/crosstool
++ cat powerpc-603.dat gcc-4.1.0-glibc-2.3.6-tls.dat
+
eval TARGET=powerpc-603-linux-gnu 'TARGET_CFLAGS="-O' '-mcpu=603"'
'GCC_EXTRA_CONFIG="--with-cpu=603' '--enable-cxx-flags=-mcpu=603"'
BINUTILS_DIR=binutils-2.16.1 GCC_CORE_DIR=gcc-3.3.6 GCC_DIR=gcc-4.1.0
GLIBC_DIR=glibc-2.3.6 LINUX_DIR=linux-2.6.15.4 LINUX_SANITIZED_HEADER_DIR=linux-libc-headers-2.6.12.0
GLIBCTHREADS_FILENAME=glibc-linuxthreads-2.3.6 GDB_DIR=gdb-6.5
'GLIBC_EXTRA_CONFIG="$GLIBC_EXTRA_CONFIG' --with-tls --with-__thread
'--enable-kernel=2.4.18"' sh all.sh --notest
++ TARGET=powerpc-603-linux-gnu
++ TARGET_CFLAGS='-O -mcpu=603'
++ GCC_EXTRA_CONFIG='--with-cpu=603 --enable-cxx-flags=-mcpu=603'
++ BINUTILS_DIR=binutils-2.16.1
++ GCC_CORE_DIR=gcc-3.3.6
++ GCC_DIR=gcc-4.1.0
++ GLIBC_DIR=glibc-2.3.6
++ LINUX_DIR=linux-2.6.15.4
++ LINUX_SANITIZED_HEADER_DIR=linux-libc-headers-2.6.12.0
++ GLIBCTHREADS_FILENAME=glibc-linuxthreads-2.3.6
++ GDB_DIR=gdb-6.5
++ GLIBC_EXTRA_CONFIG=' --with-tls --with-__thread --enable-kernel=2.4.18'
++ sh all.sh --notest
You set both LINUX_DIR and LINUX_SANITIZED_HEADER_DIR - ignoring LINUX_DIR for the build
DEJAGNU not set, so not running any regression tests
GLIBC_ADDON_OPTIONS not set, so building all glibc add-on's
KERNELCONFIG not set, so not configuring linux kernel
+ TOOLCOMBO=gcc-4.1.0-glibc-2.3.6
++ pwd
+ BUILD_DIR=/root/work/crosstool-0.43/build/powerpc-603-linux-gnu/gcc-4.1.0-glibc-2.3.6
++ pwd
+ TOP_DIR=/root/work/crosstool-0.43
+ test -z ''
+ SRC_DIR=/root/work/crosstool-0.43/build/powerpc-603-linux-gnu/gcc-4.1.0-glibc-2.3.6
+ echo 'SRC_DIR not set, so source tarballs will be unpacked in the build directory'
SRC_DIR not set, so source tarballs will be unpacked in the build directory
+ case x$PREFIX in
+ case x$USER in
+ abort 'Don'\''t run all.sh or crosstool.sh as root, it'\''s dangerous'
+ echo 'Don'\''t' run all.sh or crosstool.sh as root, 'it'\''s' dangerous
Don't run all.sh or crosstool.sh as root, it's dangerous
+ exec false

=================

The point of this exercise is to build a compiler to build Mono so that
I can run .NET programs on the MPC8313.

I would really appreciate any help.

Thanks,
Chris Plasun
