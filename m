From: "Donald Russell" <donaldrussell@lucent.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <003401c40cfc$b019f6c0$40749498@inse.lucent.com>
Reply-To: "Donald Russell" <donaldrussell@lucent.com>
Subject: kernel 2.6.4 build problem under CYGWIN
Date: Thu, 18 Mar 2004 10:21:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a cygwin system set up w/gnu cross compile tools for ppc.
Tools seem to work OK.

drussell@YY232 /usr/src/linux-2.6.4
$ /usr/local/powerpc/bin/powerpc-eabi-gcc -v
Reading specs from
/usr/local/powerpc/lib/gcc-lib/powerpc-eabi/3.0/specs
Configured with:
/usr/local/src/gnu/gcc-3.0/configure --enable-languages=c,c++ --
with-included-gettext --enable-shared --enable-threads --target=
powerpc-eabi --prefix=/usr/local/powerpc -v
Thread model: single
gcc version 3.0

1st question: Can a cross compiled kernel be built under CYGWIN
successfully ? Has anyone done this ?

2nd question:
I downloaded and attempted to build a kernel for the Motorola
mpc8560ADS board per
Moto  AN2579.pdf

 "make xconfig  " command results in the following error.

drussell@YY232 /usr/src/linux-2.6.4
$ make
Makefile:398: .config: No such file or directory
  CHK     include/linux/version.h
  HOSTCC  scripts/fixdep
fixdep:
: No such file or directory
make[1]: *** [scripts/fixdep] Error 2
make: *** [scripts] Error 2

fixdep.exe is created in  /scripts/ dir

Any help appreciated.

Don Russell

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
