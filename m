From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting Linux without bootloader on Sandpoint X3 with PPC755 CPU, Montavista Linux
Date: Mon, 9 Jun 2003 13:42:32 -0400
Message-ID: <000f01c32eae$819c7ed0$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <E19PMLT-000Hhi-00.xol-mail-ru@f16.mail.ru>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 I try to boot MontaVista Linux on Sandpoint X3 with PPC755 CPU.
I make zImage.initrd for Sandpoint X3, and loaded it on the SDRAM at
0x800000.
I used bdi to initialize memory controller and load the binary image of
zImage.initrd on the SDRAM.
Although I don't use bootloader, I can read/write SDRAM without any problem.
The only change I made is memory size change in
arch/ppc/platform/sandpoint_setup.c file

 size = 128*1024*1024;   /* 128 M bytes */

I also changed the size of memory in the boot parameters.

 However, the Linux doesn't seem to boot properly.
The serial line keeps silent.
It keeps running. When I halt the running with bdi, it is in
"emit_log_char".
Could anybody tell me what's possibly wrong?

 Thanks,

 Dong-In

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
