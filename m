Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by ozlabs.org (Postfix) with SMTP id 73E3FDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 16:48:16 +1000 (EST)
In-Reply-To: <20070814215438.3C7AA1B7006C@mail148-cpk.bigfish.com>
Date: Wed, 15 Aug 2007 08:41:33 +0200 (CEST)
To: =?us-ascii?Q?Stephen=20Neuendorffer?= <stephen.neuendorffer@xilinx.com>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?RE=3A=20Device=20Tree=20tool=20=5Bwas=20RE=3A=20=5BPATCH=5D=20Consolidate=20XILINX=5FVIRTEXboardsupport=5D?=
Mime-Version: 1.0
Message-Id: <2934.5453-20654-824518122-1187160093@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

>I've managed to get the first step working: a microblaze system
>advertising of_devices in 2.6 using a flat device tree.  

It's great news.

>Is there a concensus on how microblaze systems should get booted?
>Currently,
>I'm linking the device tree directly into the kernel itself, loading the
>whole
>mess using SystemAce and the start address jumps directly into the
>kernel, which
>is quite a bit different than the way powerpc works.  It's certainly
>simpler:
>maybe too simple.  At the same time, replicating
>the complexity of arch/powerpc with separate boot code may or may not be
>worth it...
>Any thoughts?

Microblaze can be boot via U-BOOT. U-BOOT supports FDT for some PowerPC boards.
I would like to help with this part of bootloader code. 

Do you have any EDK script for generation FDT? 

Best regards,
Michal Simek
