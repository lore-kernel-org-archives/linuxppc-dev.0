Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 72394B6EED
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 15:52:42 +1000 (EST)
Received: from mail122-va3 (localhost.localdomain [127.0.0.1])	by
	mail122-va3-R.bigfish.com (Postfix) with ESMTP id 8633F2681CD	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 05:52:38 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.243])	by
	mail122-va3.bigfish.com (Postfix) with ESMTP id 41C4313A804B	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 05:52:38 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6Q5qJNx019204	for <linuxppc-dev@ozlabs.org>;
	Sun, 25 Jul 2010 22:52:29 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q5qNoc009953	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 00:52:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 0/6] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Mon, 26 Jul 2010 13:52:15 +0800
Message-ID: <73839B4A0818E747864426270AC332C3054005B3@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726003618.GF25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<20100726003618.GF25419@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:36 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 0/6] refactor spi_mpc8xxx.c and add eSPI=20
> controller support
>=20
> On Tue, Jul 20, 2010 at 10:08:19AM +0800, Mingkai Hu wrote:
> > This patchset refactor the file spi_mpc8xxx.c to abstract=20
> some common=20
> > code as a lib used by the SPI/eSPI controller driver, move the SPI=20
> > controller driver code to fsl_spi.c, and add the eSPI=20
> controller support with fsl_espi.c.
> >=20
> > Tested on P4080DS and MPC8536DS board based on latest Linux tree.
> >=20
> > [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI=20
> > controller [PATCH 2/6] eSPI: add eSPI controller support=20
> [PATCH 3/6]=20
> > of/spi: add support to parse the SPI flash's partitions [PATCH 4/6]=20
> > mtd: m25p80: change the read function to read page by page=20
> [PATCH 5/6]=20
> > powerpc/of: add eSPI controller dts bindings [PATCH 6/6]=20
> DTS: add SPI=20
> > flash(s25fl128p01) support on p4080ds and mpc8536ds board
>=20
> Hi Mingkai,
>=20
> Thanks for the patches, I've just sent my review.  Make sure=20
> you cc: spi-devel-general@lists.sourceforge.net when you post v2
>=20

Many thanks for you  review and comments, I'll submit the v2 version
with cc to spi-devel-general maillist.

Thanks,
Mingkai
