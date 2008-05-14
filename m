Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 519CEDDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 13:54:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4E3s0VF003197
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 20:54:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4E3rxGt015955
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 22:54:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
Date: Wed, 14 May 2008 11:53:57 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F16798@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080514114523.ae20b0da.sfr@canb.auug.org.au>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru><20080513141459.GC15717@polina.dev.rtsoft.ru>
	<20080514114523.ae20b0da.sfr@canb.auug.org.au>
From: "Chen Gong" <G.Chen@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Cc: Wood Scott <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Tabi Timur <timur@freescale.com>
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
> From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Stephen Rothwell
> Sent: 2008?5?14? 9:45
> To: Anton Vorontsov
> Cc: Wood Scott; linuxppc-dev@ozlabs.org; Wim Van Sebroeck; Tabi Timur
> Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
>=20
> On Tue, 13 May 2008 18:14:59 +0400 Anton Vorontsov=20
> <avorontsov@ru.mvista.com> wrote:
> >
> > Rename the driver because now we support some MPC86xx processors.
What I want to know is that what about watchdog for booke(85xx) ?
> >=20
> > There are no changes to the mpc83xx_wdt.c file, yet. When=20
> possible, we=20
> > do file renames and changes separately (because Linus once=20
> asked so,=20
> > because it helps git to track the renamed files).
> >=20
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/watchdog/Kconfig       |    4 +-
> >  drivers/watchdog/Makefile      |    2 +-
> >  drivers/watchdog/mpc83xx_wdt.c |  273=20
> > ----------------------------------------
> >  drivers/watchdog/mpc8xxx_wdt.c |  273=20
> > ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 276 insertions(+), 276 deletions(-)  delete mode=20
> > 100644 drivers/watchdog/mpc83xx_wdt.c  create mode 100644=20
> > drivers/watchdog/mpc8xxx_wdt.c
>=20
> Doing this status with "git diff -M --stat" would show us if=20
> the file was just renamed or if there were some changes as well ...
>=20
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>=20
