Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id F3602DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 19:09:45 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0C89h0B017026
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 01:09:43 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0C89fNq020204
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 02:09:42 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 16:09:29 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816A58@zch01exm20.fsl.freescale.net>
In-Reply-To: <EDDAA8FA-2056-4690-AE89-2C7E46BEFD14@kernel.crashing.org>
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

 Hi Kumar,

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:42
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:
>=20
> > Hi Paul,
> >
> > This series of patch add support to fully comply with IEEE-754=20
> > standard for E500/E500v2 core when hardware floating point=20
> compiling=20
> > is used.
> >
> > Ebony
>=20
> Here are some general comments:
> * We should be able to support math-emu (as it stands) and=20
> the fixup handling [you break math-emu]

I don't think I break the math-emu. I think the codes I added have
no impact to the existing math-emu.

> * Copyrights / header comments should give credit to the orig=20
> math- emu code
I'd like to do this, but in most handler codes, I can't find copyright =
information
of the orig authors. I think the math-emu code comes from glibc. In the
sigfpe_handler.c, I gave credit to the orig author.

> * Why isn't there any handling of SPEFloatingPointRound exceptions?

I think the SPEFloatingPointRound exception is not necessary to handle =
if we
handle floating point exception this way.=20

>=20
> - k
>=20
