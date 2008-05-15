Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 030C7DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 13:11:42 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4F3BZ5g018561
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 20:11:36 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4F3BXjA019534
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 22:11:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
Date: Thu, 15 May 2008 11:11:30 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F169C2@zch01exm21.fsl.freescale.net>
In-Reply-To: <DA55CC6B-F9AC-4ACB-A704-D61CCEB98023@kernel.crashing.org>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru><20080513141459.GC15717@polina.dev.rtsoft.ru>
	<20080514114523.ae20b0da.sfr@canb.auug.org.au>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16798@zch01exm21.fsl.freescale.net>
	<DA55CC6B-F9AC-4ACB-A704-D61CCEB98023@kernel.crashing.org>
From: "Chen Gong" <G.Chen@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Wood Scott <scottwood@freescale.com>,
	Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: 2008?5?14? 23:03
> To: Chen Gong
> Cc: Stephen Rothwell; Anton Vorontsov; Wood Scott;=20
> linuxppc-dev@ozlabs.org; Wim Van Sebroeck; Tabi Timur
> Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
>=20
>=20
> On May 13, 2008, at 10:53 PM, Chen Gong wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org
> >> [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]
> >> On Behalf Of Stephen Rothwell
> >> Sent: 2008?5?14? 9:45
> >> To: Anton Vorontsov
> >> Cc: Wood Scott; linuxppc-dev@ozlabs.org; Wim Van Sebroeck;=20
> Tabi Timur
> >> Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to=20
> >> mpc8xxx_wdt
> >>
> >> On Tue, 13 May 2008 18:14:59 +0400 Anton Vorontsov=20
> >> <avorontsov@ru.mvista.com> wrote:
> >>>
> >>> Rename the driver because now we support some MPC86xx processors.
> > What I want to know is that what about watchdog for booke(85xx) ?
>=20
> what about it, its still there in the tree (booke_wdt.c). =20
> This driver is for a SoC level watchdog that exists on 8xx,=20
> 83xx and 8610.
Yeah, I know it well, but I'm just afraid it will take confusion for
user.
>=20
> - k
>=20
