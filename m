Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E609CB7B66
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 16:36:39 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB15aa02007660
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 22:36:36 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nB15f2BJ023095
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 23:41:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Date: Tue, 1 Dec 2009 11:06:32 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A0801222492@zin33exm23.fsl.freescale.net>
In-Reply-To: <20091120173859.GC18967@loki.buserror.net>
References: <181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
	<F2F605B667B24B489C904986E0D60A08012221DF@zin33exm23.fsl.freescale.net>
	<20091120173859.GC18967@loki.buserror.net>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Wood Scott-B07421" <B07421@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Wood Scott-B07421=20
> Sent: Friday, November 20, 2009 11:09 PM
> > Cache-sram does not have any device tree entry since it is not a=20
> > hardware as such. Putting it under chosen can be another option.
> > I think, Scott (cc'ed) was of the opinion that since 32b=20
> base address=20
> > support is missing; so there is no point in moving this=20
> address to the=20
> > command line and .config should be okay for now for it.
>=20
> I don't know what you mean by "32b base address support is=20
> missing".  I have no objection to putting it on the command line.

It was a typo, it should be missing 36b address support. Since the
kernel=20
did not run under different environment (i.e 32b / 36b base address); so
it=20
was decided that .config may be okay for this.

>=20
> -Scott
>=20

Thanks,
Vivek
