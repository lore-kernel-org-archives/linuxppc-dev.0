Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id 7A25ADE0BE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 13:10:40 +1000 (EST)
Received: from webmail.lesc.ufc.br (unknown [192.168.0.1])
	by lesc0.lesc.ufc.br (Postfix) with ESMTP id 7BD6964C665
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 23:41:02 -0300 (BRT)
MIME-Version: 1.0
Date: Tue, 15 Apr 2008 23:40:28 -0300
From: rodolfo <rodolfo@lesc.ufc.br>
To: Linuxppc embedded <linuxppc-embedded@ozlabs.org>
Subject: SystemACE on Kernel 2.6
Message-ID: <7aa21da00314dfb40c194e38e2488048@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant likely,

I got kernel 2.6.20 from kernel.org and I want boot it on XUP Virtex II Pro
University board.
I edited the Makefile putting:
 ARCH? = ppc
 CROSS_COMPILE? = ppc_4xx-
But I can't see anything about SystemACE driver on make menuconfig from
this Kernel. How can I add SystemACE controler?

I compiled the kernel repeatedly generating a file zImage.elf. I used this
file with the genace.tcl from Xilinx and this opt file:
-jprog
-board user
-target ppc_hw
-hw implementation/download.bit
-elf zImage.elf
-configdevice devicenr 1 idcode 0x1127e093 irlength 14 partname xc2vp30
-debugdevice devicenr 1 cpunr 1
-ace system.ace

to generated ace file and put it in FAT16 partition of CF card, like a lot
of references in web. But it doesn't works!
Which IP cores must be present in my project of the EDK?
Still speaking in the EDK Did i have to mark bram with ppc_405_0_bootloop? 
Did I have to mark bram whit any software project?

My work in with Linux on Virtex don't work. I am almost dropping...

Thanks!!
