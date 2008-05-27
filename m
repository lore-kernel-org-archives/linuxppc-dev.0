Return-Path: <G.Chen@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE1E1DDF81
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 12:11:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4R2BmTS013069
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 19:11:48 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4R2BkiQ024068
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 21:11:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/4] [MMC] mmc_spi: add polling support for
	thecarddetectline
Date: Tue, 27 May 2008 10:11:45 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F5939E@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080526153747.GA31663@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
	<20080522123838.GA27149@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F176EF@zch01exm21.fsl.freescale.net>
	<20080526153747.GA31663@polina.dev.rtsoft.ru>
From: "Chen Gong" <G.Chen@freescale.com>
To: <avorontsov@ru.mvista.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Tabi Timur <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
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
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: 2008?5?26? 23:38
> To: Chen Gong
> Cc: Kumar Gala; David Brownell; Pierre Ossman;=20
> linuxppc-dev@ozlabs.org;=20
> spi-devel-general@lists.sourceforge.net;=20
> linux-kernel@vger.kernel.org; Tabi Timur
> Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support=20
> for thecarddetectline
>=20
> On Thu, May 22, 2008 at 09:44:57PM +0800, Chen Gong wrote:
> [...]
> > > > I want to know whether every card working well ? Because
> > > I'm working
> > > > For 83xx MMC-over-SPI support, the presented concrete
> > > methods I used
> > > > as you do, but only 256M card seems good, 512M or 1G/2G
> > > card all have
> > > > some problems
> > >=20
> > > So far I don't have cards larger than 256M. Will try to get one=20
> > > though.
> > >=20
> > Thanks, if you have any new test report pls contact me.
>=20
> Just tested with Apacer 1GB MicroSD (connected through dumb=20
> adapter), it works quite well here. I've successfully wrote=20
> 10 mb file onto ext2 formatted partition...

Oh, thanks for your info. The card I used is Kingston 1G SD card.

>=20
> > BTW, a fews days ago Joakim Tjernlund made a heavy fix for=20
> > spi_mpc83xx.c to resolve clock glitch. But it looks no any=20
> impact for=20
> > me, but maybe it has positive effect for you.
>=20
> Yup, I use it.
>=20
> Btw, which mmc driver are you using? The one from MPC8610HPCD=20
> BSP or mainline's mmc_spi?

:-( the mmc driver now in the MPC8610HPCD BSP is ported from uClinux
 by me, it has many problems, because at that time MMC-over-SPI driver
doen't exist in the kernel.
