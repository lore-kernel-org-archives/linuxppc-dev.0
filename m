Return-Path: <Vivek.Mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 759AEB7B93
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 16:42:46 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9M5gRqY000211
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 22:42:38 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9M5j9MV002062
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 00:45:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v3 2/3] powerpc/fsl: 85xx: document cache-sram
Date: Thu, 22 Oct 2009 11:12:21 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A080122179E@zin33exm23.fsl.freescale.net>
In-Reply-To: <20091021175012.ED29819F73@gemini.denx.de>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com><1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<20091021175012.ED29819F73@gemini.denx.de>
From: "Mahajan Vivek-B08308" <Vivek.Mahajan@freescale.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk Sent: Wednesday, October 21, 2009 11:20 PM

> > * How to enable it from a low level driver
> > * How to set its size
> ...
> > +The size of the above cache SRAM memory window is passed via the=20
> > +kernel command line as <cache-sram-size=3D....>
>=20
> Would it not make more sense to configure this property=20
> through the device tree?=20

Since this parameter needs to be passed run time to the kernel=20
and it was not preconfigured by u-boot; so it landed in the=20
cmdline instead of the device tree.

>=20
> Best regards,
>=20
> Wolfgang Denk
>=20

Thanks,
Vivek
