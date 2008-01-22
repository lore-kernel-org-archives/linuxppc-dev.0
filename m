Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A305DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 04:40:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Generated xilinx linux 2.6  image sections
Date: Tue, 22 Jan 2008 09:40:29 -0800
In-Reply-To: <15018508.post@talk.nabble.com>
References: <14997109.post@talk.nabble.com><20080121184553.569BF179805C@mail212-sin.bigfish.com><15015244.post@talk.nabble.com>
	<15018508.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "greenlean" <jmgomez@atc.ugr.es>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080122174031.27E821470057@mail50-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


That would do it!
What's strange is that the testapps linked into the second bank by
default, which *happened* to work.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of greenlean
> Sent: Tuesday, January 22, 2008 5:29 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: Generated xilinx linux 2.6 image sections
>=20
>=20
> Now It's running the problem was the DDR controller I was including
the 512
> one but I'm working with a 256 DDR module .......
>=20
> Thanks for the orientation, really usefull.
>=20
> Bye.
>=20
>=20
> Stephen Neuendorffer wrote:
> >
> > The testapps are generated using a different linker script.
> >
> > Based on what you sent out, it looks like your EDK design has a
memory
> > at 0x10000000, but this is
> > not reflected in the linux image you've generated.  This makes me
> > suspect that you haven't generated the BSP and copied the
appropriate
> > xparameters file over xparameters_xup.h (assuming you are using
> > CONFIG_XILINX_XUPV2P).
> >
> > Steve
> >
> >> -----Original Message-----
> >> From:
linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> > [mailto:linuxppc-embedded-
> >> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of
greenlean
> >> Sent: Monday, January 21, 2008 5:06 AM
> >> To: linuxppc-embedded@ozlabs.org
> >> Subject: Generated xilinx linux 2.6 image sections
> >>
> >>
> >> Hi all,
> >>
> >> I'm trying to boot the 2.6 xilinx kernel downloaded from their git
> > server in
> >> the XUPV2P board I'm really having troubles (I can't see anything
in
> > the
> >> minicom console terminal). I'm not seeing anything, neither the
> > ucompressing
> >> kernel string nor the prompt with the memory addresses that kernel
> > prompt at
> >> first time, so I have started to distrust of anything.
> >>
> >>
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>=20
>=20
>=20
> --
> View this message in context:
http://www.nabble.com/Generated-xilinx-linux-2.6--image-sections-
> tp14997109p15018508.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
