Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4623DDF9D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:53:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4IMr7Sj008970
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:53:07 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4IMr7JK006314
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:53:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Date: Mon, 18 May 2009 15:53:06 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2702C2D459@az33exm24.fsl.freescale.net>
In-Reply-To: <20090518221847.GA17348@iram.es>
References: <20090518173756.GA11805@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
	<20090518184752.GA12972@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D3A5@az33exm24.fsl.freescale.net>
	<20090518221847.GA17348@iram.es>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: netdev@vger.kernel.org, tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>,
	pacman@kosh.dhis.org, David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Gabriel,


> -----Original Message-----
> From: Gabriel Paubert [mailto:paubert@iram.es]
> Sent: Monday, May 18, 2009 5:19 PM
> To: Medve Emilian-EMMEDVE1
> Cc: Lennert Buytenhek; tbm@cyrius.com; LinuxPPC; pacman@kosh.dhis.org;
netdev@vger.kernel.org; David
> Miller
> Subject: Re: [PATCH] Allow selecting mv643xx_eth on Pegasos again
>=20
> Hello Medve
>=20
> On Mon, May 18, 2009 at 01:15:12PM -0700, Medve Emilian-EMMEDVE1
wrote:
> >
> > You're correct. MV64360 seems to be stale. Do you want to re-spin
your
> > patch to get rid of it?
>=20
>=20
> No problem, bu should I respin in from the current official git
> or on top of yours?

Top of the tree should be good.


Cheers,
Emil.


> > (I wouldn't create a dependency between MV643XX_ETH and PPC_CHRP.)
>=20
> Fine with me.
>=20
> 	Regards,
> 	Gabriel
