Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id B84A9DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 06:25:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux 2.6 and uboot
Date: Fri, 13 Apr 2007 13:25:17 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B4046E9F3C@monk.echelon.echcorp.com>
In-reply-to: <56EADD43-F9B3-427E-9322-AAC708EF2CCC@kernel.crashing.org>
References: <3C02138692C13C4BB675FE7EA24095293284D7@bluefin.Soneticom.local>
	<56EADD43-F9B3-427E-9322-AAC708EF2CCC@kernel.crashing.org>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Clint Thomas" <cthomas@Soneticom.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I found that when trying to build kernel 2.6.19.2 with the ELDK 4.1, and
run it on an MPC8349EMDS with u-boot 1.1.3, I had to use ARCH=3Dppc.
ARCH=3Dpowerpc would immediately hang. The different architectures use
different default kernel configuration files for the same board.

But now I am unable to get USB and MTD to work on the board, and am
wondering if ARC=3Dppc is still a viable choice on kernels newer than
about 2.6.15, or whether it lacks the best driver support. Could someone
please offer a recommendation on this issue?


> -----Original Message-----
> From: linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org] =
On
> Behalf Of Kumar Gala
> Sent: Friday, April 13, 2007 1:18 PM
> To: Clint Thomas
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux 2.6 and uboot
>=20
>=20
> On Apr 13, 2007, at 2:55 PM, Clint Thomas wrote:
>=20
> > Is there any correlation between the version of U-boot to use on a
> > board
> > and the version of the Linux kernel you plan to use? Current I'm
> > running
> > U-boot 1.1.2 with kernel 2.4.26 on my MPC85xx board, but i'm trying
to
> > migrate to the latest 2.6 kernel. I am getting a kernel hang at boot
> > when it registers socket family 17, so I was wondering if it might
> > have
> > to do with u-boot before exploring the debug route.
>=20
> That's an odd place to hang. Which 2.6 kernel are you using?  Also
> are you using arch/ppc or arch/powerpc?
>=20
> - k
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
