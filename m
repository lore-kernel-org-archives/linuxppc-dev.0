Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: =?iso-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling Kernel 2.6 for ppc32
Date: Tue, 9 Sep 2003 18:17:58 +0200
Message-ID: <000001c376ed$eef95430$0f21258d@fhkonstanz.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I tried to compile the kernel 2.6. test 4 for PowerPC. I used the cross
compile tool chain ELDK V2.1 from Denx http://www.denx.de/. I am not
able to make the kernel, because I get the following error.

In file included from include/asm/system.h:8,
                 from include/linux/list.h:8,
                 from include/linux/signal.h:4,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/kernel.h:10: stdarg.h: Datei oder Verzeichnis nicht
gefunden In file included from include/asm/system.h:8,
                 from include/linux/list.h:8,
                 from include/linux/signal.h:4,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/kernel.h:73: parse error before `va_list'
include/linux/kernel.h:73: warning: function declaration isn't a
prototype
include/linux/kernel.h:76: parse error before `va_list'
include/linux/kernel.h:76: warning: function declaration isn't a
prototype
include/linux/kernel.h:80: parse error before `va_list'
include/linux/kernel.h:80: warning: function declaration isn't a
prototype
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Fehler 1
make: *** [arch/ppc/kernel/asm-offsets.s] Fehler 2

I have no problems to compile the kernel for i386 mit the nativ gcc. Can
it be that the GCC 2.95.4 is to old or is there a missing option?

André


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
