Message-ID: <001b01c16d2a$976a61b0$870e8b3d@ming>
From: "Chen Yaoming" <ymchen@ocdtt.com>
To: "Keith Outwater" <Keith_Outwater@mvis.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <E62DBC698514D511A1AC0003470C1314EE2B83@EXCHANGE>
Subject: Re: Problems building ppc cross compiler under RH7.2 x86
Date: Thu, 15 Nov 2001 00:37:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


edit GLIBC_INSTALL_PATH/libc.so as the following:

/* GNU ld script
   Use the shared library, but some functions are only in
   the static library, so try that secondarily.  */
GROUP ( /lib/libc.so.6 /lib/libc_nonshared.a )


----- Original Message -----
From: "Keith Outwater" <Keith_Outwater@mvis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, November 14, 2001 10:06 PM
Subject: Problems building ppc cross compiler under RH7.2 x86


>
> Greetings all -
> I'm trying to build a powerpc-linux cross compiler on a stock Redhat 7.2
x86
> system.
>
> I've followed all of the steps in the "Cross Development mini-howto for
PPC
> Linux " at
> http://penguinppc.org/embedded/cross-compiling/ to the letter, but the
build
> fails on the
> "Rebuilding gcc to use glibc" step in the mini-howto with the following
> error:
>
> .
> .
> .
> Configuring in powerpc-linux/libiberty
> loading cache ./config.cache
> checking host system type... powerpc-unknown-linux-gnu
> checking build system type... i686-pc-linux-gnu
> checking for powerpc-linux-ar... powerpc-linux-ar
> checking for powerpc-linux-ranlib... powerpc-linux-ranlib
> checking for gcc...
> /home/keith/projects/mpc860-linux/tools/build-gcc/gcc/xgcc
> -B/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/
> -B/usr/local/powerpc-linux/bin/
> checking whether we are using GNU C... yes
> checking whether
/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/xgcc
> -B/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/
> -B/usr/local/powerpc-linux/bin/ accepts -g... yes
> checking for POSIXized ISC... no
> checking for a BSD compatible install... /usr/bin/install -c
> Appending ../../../gcc-2.95.2/libiberty/config/../../config/mh-ppcpic to
> xhost-mkfrag
> xhost-mkfrag is unchanged
> checking how to run the C preprocessor...
> /home/keith/projects/mpc860-linux/tools/build-gcc/gcc/xgcc
> -B/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/
> -B/usr/local/powerpc-linux/bin/ -E
> checking for sys/file.h... yes
> checking for sys/param.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for unistd.h... yes
> checking for strings.h... yes
> checking for sys/time.h... yes
> checking for sys/resource.h... yes
> checking for sys/wait.h that is POSIX.1 compatible... yes
> checking whether the C compiler
> (/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/xgcc
> -B/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/
> -B/usr/local/powerpc-linux/bin/ -g -O2 ) works... no
> configure: error: installation or configuration problem: C compiler cannot
> create executables.
> make[1]: Entering directory
> `/home/keith/projects/mpc860-linux/tools/build-gcc/powerpc-linux/libio'
> test x"yes" != xyes || \
>   /home/keith/projects/mpc860-linux/tools/build-gcc/gcc/xgcc
> -B/home/keith/projects/mpc860-linux/tools/build-gcc/gcc/
> -B/usr/local/powerpc-linux/bin/ -c -g -O2 -fvtable-thunks -D_GNU_SOURCE
> -fno-implicit-templates -I. -I../../../gcc-2.95.2/libio -nostdinc++
> -D_IO_MTSAFE_IO -fPIC ../../../gcc-2.95.2/libio/indstream.cc -o
> pic/indstream.o
> ../../../gcc-2.95.2/libio/indstream.cc: In method `struct streampos
> indirectbuf::seekoff(long long int, ios::seek_dir, int = 3)':
> ../../../gcc-2.95.2/libio/indstream.cc:82: `struct streampos' used where a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:85: `struct streampos' used where a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:87: `struct streampos' used where a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:89: conversion from `int' to
> non-scalar type `streampos' requested
> ../../../gcc-2.95.2/libio/indstream.cc: In method `struct streampos
> indirectbuf::seekpos(_G_fpos64_t, int = 3)':
> ../../../gcc-2.95.2/libio/indstream.cc:99: `struct streampos' used where a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:102: `struct streampos' used where
a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:104: `struct streampos' used where
a
> `int' was expected
> ../../../gcc-2.95.2/libio/indstream.cc:106: conversion from `int' to
> non-scalar type `streampos' requested
> make[1]: *** [indstream.o] Error 1
> make[1]: Leaving directory
> `/home/keith/projects/mpc860-linux/tools/build-gcc/powerpc-linux/libio'
> make: *** [all-target-libio] Error 2
>
>
> I'd appreciate any help or suggestions on how to solve this problem.
>
> Thanks!
> Keith
>
> Keith Outwater
> Sr. Electrical Engineer
> Microvision, Inc.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
