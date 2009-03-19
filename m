Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws41.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.231]) by ozlabs.org (Postfix) with ESMTP id E7B2CDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 20:51:44 +1100 (EST)
Received: from ws-87.localnet (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws41.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n2J9pbNA026399
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 10:51:38 +0100
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problem with radeonfb on PowerPC 7448&MV64560
Date: Thu, 19 Mar 2009 10:51:37 +0100
References: <200903171630.25340.edfuchs@uni-kassel.de>
	<1237331100.25062.166.camel@pasglop>
In-Reply-To: <1237331100.25062.166.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903191051.37875.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mittwoch 18 M=E4rz 2009 00:05:00 schrieb Benjamin Herrenschmidt:
> On Tue, 2009-03-17 at 16:30 +0100, Eduard Fuchs wrote:
> > Hi all,
> >
> > since several days I'm trying to run an ATI 9250 (PCI) graphic card und=
er
> > Linux Kernel 2.6.27.19. Nevertheless without success. The kernel shows
> > the following message:
> >
> > videoboot: Booting PCI video card bus 0, function 0, device 7
> > biosEmu: undefined interrupt 15h called!
> > biosEmu/bios.int42: unknown function AH=3D0x0, AL=3D0x7, BL=3D0x0
>
> The above comes from some patches you added to the kernel ? You should
> probably do the softboot in the firmware instead...

Yes. I'm using the videoboot-2.6x.patch (this patch contain also the xf86em=
u=20
from www.scitechsoft.com). With this pach the radeon card work properly wit=
h=20
2.6.12 kernel version. On the 2.6.27 kernel the "videoboot" fetch the bios=
=20
from the video card and start them in the xf86emu.

Can I initialize the video card in uboot too?

>
> > radeonfb (0000:00:07.0): Cannot match card to OF node !
>
> The above should be mostly harmless.
>
> > RADEON: CHIP_FAMILY 10 (0xa)
> > RADEON: MMIO_BASE 0xf1058000
> > RADEON: MMIO_BASE_PHYS 0x88000000
> > radeonfb (0000:00:07.0): Found 0k of SDRAM 64 bits wide videoram
> > RADEON: Try map FB Phys 0x80000000, size 0, 16777216. 0
>
> The above sounds wrong, was the card properly initialized ? Looks like
> your videoboot failed...

I dont know what exactly happens when the xf86emu runs the video bios and i=
=20
have no idea how can i verify that the card was properly initialized.

Best regards

Eduard Fuchs
