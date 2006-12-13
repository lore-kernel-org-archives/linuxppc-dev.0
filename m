Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id AB79667C67
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 21:05:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Wed, 13 Dec 2006 11:05:03 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939BA6B6D@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Li Yang-r58472 [mailto:LeoLi@freescale.com]=20
> Sent: 13 December 2006 10:54
> To: Joakim Tjernlund; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
>=20
> The data shifts for receive register are truly different.
> Please also send such patch to SPI list:
> spi-devel-general@lists.sourceforge.net

Not only receive register, transmit is also changed.

Will send an updated patch to spi-devel-general@lists.sourceforge.net
instead of here.

    Jocke
[SNIP]
