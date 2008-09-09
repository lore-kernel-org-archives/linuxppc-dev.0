Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 3B61EDDFC1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 04:24:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Device Tree
Date: Tue, 9 Sep 2008 12:24:18 -0600
In-Reply-To: <48C6BE14.9030305@team-ctech.de>
References: <48C69990.9040604@team-ctech.de>
	<20080909181107.E1575A28068@mail71-va3.bigfish.com>
	<48C6BE14.9030305@team-ctech.de>
From: John Linn <John.Linn@xilinx.com>
To: "Georg Schardt" <schardt@team-ctech.de>
Message-ID: <20080909182420.EF19B380067@mail31-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It is not integrated into the EDK, you need to pull it from our git tree
and use it from the EDK.

-- John

Here's part of the wiki page.

Generating a Device Tree

The Linux kernel from the git tree has device tree files, ml507.dts and
ml405.dts, in the arch/powerpc/boot/dts directory which are designed to
work with the hardware reference designs available from this site. Users
who have a Xilinx board, ML405 or ML507, should build the Linux kernel
using the provided dts file to get a solid baseline before generating a
new device tree file. After a baseline is established, the new dts files
can be compared to the existing to verify any differences.

The page, Generating A Device Tree, has details on how to generate a
device tree for the arch/powerpc Linux kernel.




> -----Original Message-----
> From: Georg Schardt [mailto:schardt@team-ctech.de]
> Sent: Tuesday, September 09, 2008 12:19 PM
> To: John Linn
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Device Tree
> =

> Hi John,
> =

> yes, i found the wiki link in another post of you. nice , thank you.
> can you tell me how to generate the dts file in the EDK 10.2 ?  i have
> read that the gen_mhs_devtree script is now integrated ? i see no
> menu-item or config option ?
> =

> regards
> georg
> =

> =

> =

> John Linn wrote:
> > Hi Georg,
> >
> > Our git tree, git://git.xilinx.com, has support for the ML405 board
> > which is a V4 board. The following wiki page,
http://xilinx.wikidot.com,
> > shows how to generate a device tree for the kernel and other details
> > you'll need.
> >
> > The kernel from our git tree is configured for the device tree using
the
> > default kernel configuration.
> >
> > The mainline kernel is now more up to date also as we got many of
the
> > changes into the mainline, but we are still working on some of the
> > device drivers.
> >
> > Thanks,
> > John
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> >>
> > [mailto:linuxppc-embedded-
> >
> >> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Georg Schardt
> >> Sent: Tuesday, September 09, 2008 9:43 AM
> >> To: linuxppc-embedded@ozlabs.org
> >> Subject: Device Tree
> >>
> >> Hi,
> >>
> >> im searching for informations about the flatten device trees. the
only
> >> thing i know is, that the device tree is a kind of data-structure
> >>
> > which
> >
> >> the bios or bootloader gives to the operation system.
> >>
> >> until now, i boot linux with uboot without a device tree, but newer
> >> kernel wants a devicetree, i think ??
> >> i use a virtex4 board with an integrated powerpc
> >>
> >> how can i create the device tree file ?
> >> how must the linux kernel be configured ?
> >> is there a good internet page with informations ?
> >>
> >>
> >> thanks
> >> regards
> >> georg
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >
> >
> > This email and any attachments are intended for the sole use of the
named recipient(s) and
> contain(s) confidential information that may be proprietary,
privileged or copyrighted under
> applicable law. If you are not the intended recipient, do not read,
copy, or forward this email
> message or any attachments. Delete this email message and any
attachments immediately.
> >
> >
> >
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
