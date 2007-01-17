Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix2-g20.free.fr (postfix2-g20.free.fr [212.27.60.43])
	by ozlabs.org (Postfix) with ESMTP id DB221DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 01:02:58 +1100 (EST)
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 795C6921850
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 14:03:04 +0100 (CET)
Received: from CRESITTLAB (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp6-g19.free.fr (Postfix) with ESMTP id A65324395A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 15:02:52 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Temac and Sysace for ML403
Date: Wed, 17 Jan 2007 15:02:51 +0100
Message-ID: <000001c73a40$2df61b50$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ameet,

I've a few problems to run Linux 2.6.17.1 on ML403 board following your
tutoarial instrcutions.

I've downloaded Linux 2.6.17.1 Kernel source from kernel.org, apply
MVITSA TEMAC patches from PAULUS and then apply the sysace_after_temac
patch.
The Kernel compile properly if I do not include TEMAC and SYSACE. This
kernel boot properly and ends with a kernel panic due to root file
system not detected.

Then If I try to include only SYSACE and EXT3 file support the kernel
did not compile (XST_ASSERT functions not found.... in
xilinx_sysace/adapter.c file)
To compile without source code modification I need to include TEMAC in
the kernel configuration.

This Kernel boot properly, detect sysaxe (xsa: xsa1 xsa2) with a compact
flash with two partitions but hangs just after 

[    3.631175]  xsa: xsa1 xsa2
[    3.682436] tun: Universal TUN/TAP device driver, 1.6
[    3.743219] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.820309] Data machine check in kernel mode.

If I try to add more kernel configurations based on BYU instructions
(refered on your tutorial) then I only succeed to obtain a :

Oops : Kernel access bad area sig : 11

Error message


The hardware is a design from scratch using EDK 8.2 SP2.
TEMAC version is plb_temac v3.00a, hard-temac v3.00b

I suspect the hardware but I'm not sure about that. Hardware compilation
took a while on my computer so I would appreciate if you could tell me
the temac version you have used to port Linux 2.6.17.1 with TEMAC and
SYSACE.

Furthermore if you have a .config file available for Kernel
configuration it would help me, beacause I'm not familiar with kernel
configuration.

Regards


CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com 
Web : http://www.cresitt.com
