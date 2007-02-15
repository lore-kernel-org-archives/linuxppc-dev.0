Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 28C7BDDEFC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:46:03 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1FLk09W016924
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 14:46:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FLk03c011151
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 15:46:00 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu
	and chosen nodes from all DTSfiles)
Date: Thu, 15 Feb 2007 14:45:59 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BC91@az33exm25.fsl.freescale.net>
In-Reply-To: <B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
References: <11713852392294-git-send-email-timur@freescale.com><20070214003119.GF11491@localhost.localdomain><45D29BBA.7090401@freescale.com><20070214052440.GB12609@localhost.localdomain><45D31734.7030808@freescale.com><20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, February 15, 2007 3:39 PM
> To: Yoder Stuart-B08248
> Cc: Segher Boessenkool; Benjamin Herrenschmidt;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: purpose of /chosen node (was RE: [PATCH]=20
> powerpc: delete boot-cpu and chosen nodes from all DTSfiles)
>=20
>=20
> On Feb 15, 2007, at 3:26 PM, Yoder Stuart-B08248 wrote:
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org
> >> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]
> >> On Behalf Of Segher Boessenkool
> >> Sent: Wednesday, February 14, 2007 7:40 PM
> >> To: David Gibson
> >> Cc: linuxppc-dev@ozlabs.org; Tabi Timur-B04825
> >> Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen
> >> nodes from all DTSfiles
> >>
> >>> My point is that the interrupt-controller property in
> >> /chosen *should*
> >>> be there, but it doesn't make a lot of sense for it to be=20
> set by the
> >>> bootloader (because it's a fixed property of the board).
> >>
> >> And that means it shouldn't be in /chosen at all.  It's not
> >> just a fixed property of the board, it is a physical property
> >> of the board.  It doesn't belong in /chosen.
> >
> > I agree with Segher here.  The interrupt-controller property doesn't
> > belong in /chosen.
> >
> > The 1275 OF spec says about /chosen:
> >
> >    Has properties describing parameters chosen or specified at
> >    runtime.
>=20
> I want to reiterate something Paul mentioned, any similarity=20
> that the =20
> device tree has to 1275 is strictly coincidental.

I understand that point, but mixing the types of properties in
/chosen doesn't buy us anything.  We shouldn't be shackled by
the 1275 spec, but having nodes like /chosen with designated
purpose architecturally make sense.

/chosen shouldn't be a catch-all or a convenient place to stick
stuff.  I think in this case following 1275 is a good thing.

Stuart
