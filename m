Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 66B26DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 16:40:26 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l185eMov018659
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 22:40:22 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l185eKsb011363
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 23:40:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Thu, 8 Feb 2007 13:40:18 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7E2B@zch01exm20.fsl.freescale.net>
In-Reply-To: <5B698A5A-5A2D-47D2-B1E0-32D93AD2A391@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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
> Sent: Thursday, February 08, 2007 1:19 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc V2 : Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Feb 7, 2007, at 9:50 PM, Zhu Ebony-r57400 wrote:
>=20
> > Hi Paul,
> >
> > These are the re-sent patches to add support to fully comply with
> > IEEE-754 standard for E500/E500v2 core when hardware floating point=20
> > compiling is used. Comparison with last patches I've submitted, the=20
> > following points was changed:
> >
> > 1. Add a rounding exception handler, to handle the exceptions that=20
> > would occur when rounding towards +Inf/-Inf
> >
> > 2. Using the existing exception entering/returning routine, and get=20
> > the exception instructions from regs->nip instead of=20
> reading from SRR0
> >
> > Thank you all for the comments you gave to me!
>=20
> Did you end up getting testfloat running?  I'd like to see=20
> some testing results before accepting these patches.  I think=20
> testfloat is our best bet at this point.
>=20
> - k

not yet, since it needs to be ported to powerpc platform. I will do it
as soon as possible.

B.R.
Ebony
