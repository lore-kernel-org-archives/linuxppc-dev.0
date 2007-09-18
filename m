Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45E95DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 18:56:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8I8uLa5025247
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 01:56:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8I8uKFx028253
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 03:56:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] ucc_geth: fix compilation
Date: Tue, 18 Sep 2007 16:56:18 +0800
Message-ID: <989B956029373F45A0B8AF029708189001763D1E@zch01exm26.fsl.freescale.net>
In-Reply-To: <C844988E-F6B9-44B9-AB78-C44E19A2E605@kernel.crashing.org>
References: <20070912112456.GA15556@localhost.localdomain><20070913152333.GA2381@localhost.localdomain>
	<C844988E-F6B9-44B9-AB78-C44E19A2E605@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "Jeff Garzik" <jeff@garzik.org>
Cc: linuxppc-dev@ozlabs.org, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Kumar Gala
> Sent: Friday, September 14, 2007 10:08 PM
> To: Jeff Garzik
> Cc: linuxppc-dev@ozlabs.org list; netdev
> Subject: Re: [PATCH] ucc_geth: fix compilation
>=20
>=20
> On Sep 13, 2007, at 10:23 AM, Anton Vorontsov wrote:
>=20
> > Currently qe_bd_t is used in the macro call --=20
> dma_unmap_single, which=20
> > is a no-op on PPC32, thus error is hidden today. Starting=20
> with 2.6.24,=20
> > macro will be replaced by the empty static function, and=20
> erroneous use=20
> > of qe_bd_t will trigger compilation error.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
>=20
> Jeff, I'm going to pick this up via the powerpc.git tree=20
> since its currently only broken in our for-2.6.24 branch=20
> (because of other changes in there).  Any issues?

Kumar,

Kim Phillips has posted the same patch to netdev list before Anton.
Therefore, I do prefer to use his.  Thanks

- Leo
