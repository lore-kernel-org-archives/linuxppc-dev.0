Message-ID: <001001bfb1b3$de9fa510$e50102c8@d-pengl-229.sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: problems with compiling glibc
Date: Sat, 29 Apr 2000 03:21:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,all,
I have a problem with  compiling the glibc-2.1.3 with gcc(my own
cross-compiler for
power pc).the status is :

powerpc-linux-gcc -nostdlib -nostartfiles -r -o crt1.o start.o abi-note.o
init.o
/home/lhx/powerpc-linux/bin/ld: unrecognised emulation mode: elf32ppclinux
Supported emulations: elf32ppc
collect2: ld returned 1 exit status
make[1]: *** [crt1.o] Error 1


I wonder if elf32ppclinux is  different from elf32ppc ?
why I got such an error message ?
thanks a lot .


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
