Return-Path: <roy.zeighami@hp.com>
Received: from ccerelbas01.cce.hp.com (ccerelbas01.cce.hp.com [161.114.21.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "palsmtp.hp.com",
	Issuer "RSA Data Security? Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF28E67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 03:27:19 +1100 (EST)
Received: from cceexg12.americas.cpqcorp.net (cceexg12.americas.cpqcorp.net
	[16.81.1.38])
	by ccerelbas01.cce.hp.com (Postfix) with ESMTP id 9F26E20001A8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 10:18:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 1 Mar 2005 10:14:41 -0600
Message-ID: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
From: "Zeighami, Roy" <roy.zeighami@hp.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Bawany, M. Ali \(HPSL, Richardson/STT\)" <muhammad.bawany@hp.com>
Subject: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello...

I am trying to build a kernel image for the AMCC Bamboo PPC440EP board.

My colleague downloaded a preview kit from MontaVista and that worked.

However, I am trying to build a toolchain using crosstool and create a
2.6.x kernel image.  However, when I type:

"make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-440-linux-gnu- menuconfig"

When I select 44x as the CPU type, I don't see "Bamboo" under machine
type. =20

Also, I tried building a 2.6.8 kernel image  with Ebony but I can't get
a successful build.

I get the following errors:

drivers/built-in.o(.text+0x3c7ec): In function
`floppy_release_irq_and_dma':
: undefined reference to `free_dma'
drivers/built-in.o(.text+0x3dc14): In function
`floppy_grab_irq_and_dma':
: undefined reference to `request_dma'
drivers/built-in.o(.text+0x3dddc): In function
`floppy_grab_irq_and_dma':
: undefined reference to `free_dma'
make: *** [.tmp_vmlinux1] Error 1

However, the crosstool web site says that the following combo should
build: gcc-3.4.2, glibc-2.3.3, binutils-2.15, linux-2.6.8

Any suggestions?

Also, if the kernel source provided by Monta Vista is some special
branch that isn't merged to kernel.org, does anyone know how to get the
latest source from Monta Vista?

Is one of these the version that I should be getting?

zeighami@linux-2.6.8  $ rsync source.mvista.com::
mol             Mac-On-Linux Source
libmol          Binary MOL Support Files
yaboot          Ethan's Yaboot Devel Tree
yaboot-benh     BenH's Experimental Yaboot Tree
linuxppc_2_4    LinuxPPC 2.4 BitKeeper tree, stable branch
linuxppc-2.4    "LinuxPPC branch of the official 2.4 BitKeeper tree"
linuxppc_2_4_benh       Ben's 2.4 Tree (aka, the PowerMac tree)
linuxppc_2_4_devel      LinuxPPC 2.4 BitKeeper tree, development branch
linuxppc-2.5    LinuxPPC 2.5 tree, based on Linus' BitKeeper tree
linuxppc-2.5-benh       Ben's 2.5 / 2.6 tree, based on the LinuxPPC 2.5
/ 2.6 tree.
linuxppc_2_2    LinuxPPC 2.2 BitKeeper tree

Thanks,

Roy
