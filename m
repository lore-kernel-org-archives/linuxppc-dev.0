Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: stefano.gaiotto@tin.it
Date: Wed, 11 Feb 2004 15:16:12 +0100
Message-ID: <401989520000FA56@ims4c.cp.tin.it>
Subject: Linux 2.6.2 & MPC8260
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear colleagues,

I'm trying to build Linux kernel 2.6.2 for some evaluation board with Motorola
'8260, e.g. est8260.
I'm using the following environment:

- Linux kernel 2.6.2
- gcc 3.3.2
- glibc 2.3.2
- binutils 2.14.90.0.7

After having expanded the linux kernel archive, I have only modified the
makefile as follow:

- ARCH := ppc
- CROSS_COMPILE = powerpc-linux-

Then, using "make menuconfig", I have loaded from /arch/ppc/configs the
configuration file ?est8260_defconfig?
After that, I have started the compilation with the command "make zImage"
hoping to see the compiler to reach the end of the makefile...

But after a few minutes the compiler stopps reporting the error:

  AS      arch/ppc/kernel/head.o
arch/ppc/kernel/head.S: Assembler messages:
arch/ppc/kernel/head.S:1660: Error: unsupported relocation against MSR_
make[1]: *** [arch/ppc/kernel/head.o] Error 1
make: *** [arch/ppc/kernel] Error 2


Thanks in advance for your advice.


With best regards,

	Stefano


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
