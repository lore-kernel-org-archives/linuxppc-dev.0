Return-Path: <Steve.Gray@peek-traffic.co.uk>
Received: from mail.peek.co.uk (mail.peek-traffic.co.uk [194.75.137.2])
	by ozlabs.org (Postfix) with ESMTP id E3C33DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 20:38:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: powerPC 860 Port to asm/powerpc, early_dev_init problem
Date: Tue, 5 Feb 2008 09:24:28 -0000
Message-ID: <3F0066B9E04389498E53CD30B908295C015431FB@UKSV0008.peek.prv>
From: "Gray, Steve - UK" <Steve.Gray@peek-traffic.co.uk>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi List
I have a PPC860 on our own embedded platform.
I using a denx kernel snapshot from the git repository date 4 Feb 2008
I am using U-boot 1.3.1 with CONFIG_OF_LIBFDT enable, and have ported
into the kernel tree, the necessary makefiles and Kconfig changes, to
give me a kernel that now compiles,

I am able to get this to work as required with asm/ppc, and drop to a
Busybox prompt and mount rootFS over NFS
Oon reading the list this will be dropped this summer, so I have
undertaken the role to port this into the asm/powerpc branch.
I have a problem that I am not able to understand and am looking to the
list for some help.

Using a BDI-3000 I can step through the kernel startup code and
encounter a problem as described below

early_init_devtree prom.c @ line 1042, params =3D 0x7ffec0
Call of_scan_flat_dt prom.c @ line 1058 now my debugger is showing the
passed value as 0xc07ffec0
This now results in a bus error when accessing *p at line 104 of prom.c

This Flat device tree is new to me, and to many others I guess.=20
Im pretty sure that I may of simply overlooked something with this new
flat device tree but am not sure what.=20
I also don't understand why the parameter has changed?
Can any body point me back into the right direction?
Thanks in advance
Steve
