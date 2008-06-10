Return-Path: <John.Linn@xilinx.com>
Received: from mail99-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA178DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 10:26:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: PPC to PowerPC Migration
Date: Tue, 10 Jun 2008 17:59:44 -0600
In-Reply-To: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Andy Schmidt" <andrewgschmidt@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080610235946.4BEE384804F@mail99-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrew,

We have a git server with the kernel running on the ML405 (V4) and ML507
(V5) Xilinx boards with arch/powerpc at git://git.xilinx.com.

The default configuration, using ml507_defconfig or ml405_defconfig,
uses a static device tree located in the arch/powerpc/boot/dts
directory.

>make ARCH=3Dpowerpc zImage
>make ARCH=3Dpowerpc zImage.initrd (for a ramdisk image, after putting
ramdisk image in arch/powerpc/boot directory)

zImage file is located in arch/powerpc/boot directory.

On the http://git.xilinx.com site, there's some tar files with a bit
stream to match the default kernel configuration.

Maybe this is not what you're looking for, but thought I'd offer. Others
have used this to get their own boards running with Linux.

Look at Documentation/powerpc/booting-without-of.txt for some device
tree information.

Thanks,
John Linn
Linux Development & Strategy

Xilinx is looking for more embedded Linux developers.

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Andy Schmidt
Sent: Tuesday, June 10, 2008 11:49 AM
To: linuxppc-embedded@ozlabs.org
Subject: PPC to PowerPC Migration

I am wondering if anyone has seen any good documentation for migrating
from the arch/ppc to arch/powerpc.  Specifically, I am working with a
Xilinx board so I am more accustom to the xparamters.h vs. device
trees.  I am very willing to build a (or multiple) tutorials to help
others in my situation, I just need some initial help getting started.
 If anyone can point me in the right direction, I will be sure to keep
the group (or those interested) updated on the documentation.

Thank you,
Andrew
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
