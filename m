Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B83CDDF00
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 14:50:12 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Chris Plasun <chrispl78@yahoo.com>
Subject: Re: Trouble using with Kegel cross tool chain 
In-reply-to: <407093.53240.qm@web58102.mail.re3.yahoo.com> 
References: <407093.53240.qm@web58102.mail.re3.yahoo.com>
Date: Thu, 07 May 2009 14:50:11 +1000
Message-ID: <17589.1241671811@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <407093.53240.qm@web58102.mail.re3.yahoo.com> you wrote:
> 
> Hi,
> 
> I'm getting a bit desperate trying to build a  gcc / glibc cross-toolchainfor
 
> use on a Freescale MPC8313 but am having problems.
> 
> I follow the Quick Start instructions at 
> http://www.kegel.com/crosstool/crosstool-0.43/doc/crosstool-howto.html and 
> run demo-powerpc-603.sh (is that the correct script for the MPC8313?)
> 
> I check the /opt/crosstool directory and there is nothing there.
> 
> Below are the results of running the above script:
> 
> =================
>  
> linux-66oa:~/work/crosstool-0.43 # sh demo-powerpc-603.sh 
> + TARBALLS_DIR=/root/downloads
> + RESULT_TOP=/opt/crosstool
> + export TARBALLS_DIR RESULT_TOP
> + GCC_LANGUAGES=c,c++
> + export GCC_LANGUAGES
> + mkdir -p /opt/crosstool
> ++ cat powerpc-603.dat gcc-4.1.0-glibc-2.3.6-tls.dat
> +
> eval TARGET=powerpc-603-linux-gnu 'TARGET_CFLAGS="-O' '-mcpu=603"'
> 'GCC_EXTRA_CONFIG="--with-cpu=603' '--enable-cxx-flags=-mcpu=603"'
> BINUTILS_DIR=binutils-2.16.1 GCC_CORE_DIR=gcc-3.3.6 GCC_DIR=gcc-4.1.0
> GLIBC_DIR=glibc-2.3.6 LINUX_DIR=linux-2.6.15.4 LINUX_SANITIZED_HEADER_DIR=lin
ux-libc-headers-2.6.12.0
> GLIBCTHREADS_FILENAME=glibc-linuxthreads-2.3.6 GDB_DIR=gdb-6.5
> 'GLIBC_EXTRA_CONFIG="$GLIBC_EXTRA_CONFIG' --with-tls --with-__thread
> '--enable-kernel=2.4.18"' sh all.sh --notest
> ++ TARGET=powerpc-603-linux-gnu
> ++ TARGET_CFLAGS='-O -mcpu=603'
> ++ GCC_EXTRA_CONFIG='--with-cpu=603 --enable-cxx-flags=-mcpu=603'
> ++ BINUTILS_DIR=binutils-2.16.1
> ++ GCC_CORE_DIR=gcc-3.3.6
> ++ GCC_DIR=gcc-4.1.0
> ++ GLIBC_DIR=glibc-2.3.6
> ++ LINUX_DIR=linux-2.6.15.4
> ++ LINUX_SANITIZED_HEADER_DIR=linux-libc-headers-2.6.12.0
> ++ GLIBCTHREADS_FILENAME=glibc-linuxthreads-2.3.6
> ++ GDB_DIR=gdb-6.5
> ++ GLIBC_EXTRA_CONFIG=' --with-tls --with-__thread --enable-kernel=2.4.18'
> ++ sh all.sh --notest
> You set both LINUX_DIR and LINUX_SANITIZED_HEADER_DIR - ignoring LINUX_DIR fo
r the build
> DEJAGNU not set, so not running any regression tests
> GLIBC_ADDON_OPTIONS not set, so building all glibc add-on's
> KERNELCONFIG not set, so not configuring linux kernel
> + TOOLCOMBO=gcc-4.1.0-glibc-2.3.6
> ++ pwd
> + BUILD_DIR=/root/work/crosstool-0.43/build/powerpc-603-linux-gnu/gcc-4.1.0-g
libc-2.3.6
> ++ pwd
> + TOP_DIR=/root/work/crosstool-0.43
> + test -z ''
> + SRC_DIR=/root/work/crosstool-0.43/build/powerpc-603-linux-gnu/gcc-4.1.0-gli
bc-2.3.6
> + echo 'SRC_DIR not set, so source tarballs will be unpacked in the build dir
ectory'
> SRC_DIR not set, so source tarballs will be unpacked in the build directory
> + case x$PREFIX in
> + case x$USER in
> + abort 'Don'\''t run all.sh or crosstool.sh as root, it'\''s dangerous'
> + echo 'Don'\''t' run all.sh or crosstool.sh as root, 'it'\''s' dangerous
> Don't run all.sh or crosstool.sh as root, it's dangerous
> + exec false

Are you running as root?  If so, don't.

Mikey

> 
> =================
> 
> The point of this exercise is to build a compiler to build Mono so that
> I can run .NET programs on the MPC8313.
> 
> I would really appreciate any help.
> 
> Thanks,
> Chris Plasun
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
