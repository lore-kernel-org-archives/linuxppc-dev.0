Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD6E11007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 17:45:53 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAK6jYuY014795
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 23:45:45 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAK6n89k009685
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 00:49:09 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Date: Fri, 20 Nov 2009 12:15:32 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08012221DF@zin33exm23.fsl.freescale.net>
In-Reply-To: <181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-3-git-send-email-vivek.mahajan@freescale.com>
	<181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Gala Kumar-B11780" <B11780@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Gala Kumar-B11780=20
> Sent: Thursday, November 19, 2009 7:51 PM
> > + * Cache SRAM handling for QorIQ platform
>=20
> should say PQ3 & some QorIQ platforms

Ok

>=20
> > +config FSL_85XX_CACHE_SRAM_BASE
> > +	hex
> > +	depends on FSL_85XX_CACHE_SRAM
> > +	default "0xfff00000"
> > +
>=20
> I really don't like setting the physical address this way,=20
> can we not do this via the device tree?

Cache-sram does not have any device tree entry since it is not a=20
hardware as such. Putting it under chosen can be another option.
I think, Scott (cc'ed) was of the opinion that since 32b base=20
address support is missing; so there is no point in moving this=20
address to the command line and .config should be okay for now=20
for it.

>=20
> > + * QorIQ based Cache Controller Memory Mapped Registers
>=20
> PQ3 or some QorIQ

Ok

>=20
> > + * Simple memory allocator abstraction for QorIQ (P1/P2) based
> > Cache-SRAM
>=20
> PQ3 or some QorIQ

Ok

>=20
>=20
> > +
> > +	if (!param || (strict_strtoul(param, 0, &val) < 0))
> > +		return -EINVAL;
> > +
>=20
> we should use memparse()

Ok

Thanks,
Vivek
