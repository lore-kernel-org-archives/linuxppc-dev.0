Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Mark Schaefer" <junk@markschaefer.org>
To: "'linuxppc-embedded mailing list'" <linuxppc-embedded@lists.linuxppc.org>
Subject: VxWorks.c ??
Date: Thu, 12 Jun 2003 07:46:25 -0400
Message-ID: <009c01c330d8$425ee3d0$040110ac@junior>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3EEDFF92@mailandnews.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

	I'm trying to reverse-engineer a "home gateway" - used for a home
automation project I worked on.  It currently runs VxWorks, but I'd like to
see if I can port Linux to it.  From what I can tell, it's an XPC860 with
two serial ports, a USB port, a FEC and an Rs-485 port.  It has two FLASH
chips and two RAM chips - probably 32MB of each.

	First of all, I need to replace the VxWorks boot loader with U-Boot.
I have the VxWorks loader capable of loading files from my computer via ftp,
but the Linux kernel requires virtual memory support, which the boot loader
doesn't have.  I've looked everywhere for "vxhack.c" and all the ftp sites
are gone.

	After that, I need to set up a development environment.  I have the
ppc kernel source, but I'm not able to get libc and u-boot to compile.
Should I give up and just use the ELDK?  Also, what JTAG Emulators and
programmers do you use that are compatible with Linux and MPC8xx?

Thanks in advance,

Mark
P.S.  I did search the list and read the FAQ.
P.P.S.  If someone is willing to walk me through this reverse-engineering
process, I'd be willing to write it up as a "process" FAQ.  I've found some
pretty useful tools already for decompiling the kernel code.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
