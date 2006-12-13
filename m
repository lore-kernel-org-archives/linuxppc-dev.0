Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 217ED67BE2
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 20:52:53 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kBDA7QYD029639
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 03:07:26 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kBD9qlux017771
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 03:52:49 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Wed, 13 Dec 2006 17:53:47 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D32F78C@zch01exm20.fsl.freescale.net>
In-Reply-To: <1166001747.30422.43.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The data shifts for receive register are truly different.
Please also send such patch to SPI list:
spi-devel-general@lists.sourceforge.net

- Leo

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Joakim
> Tjernlund
> Sent: Wednesday, December 13, 2006 5:22 PM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
>=20
> The MPC 832x has a different SPI controller i/f, probably due to
> its QUICC engine support. This patch adapts the spi_mpx83xx driver to
> be usable on QE based 83xx cpus.
>=20
>  Jocke
>=20
> PS.
>    Sorry for the attatcment, I have yet to figure out how to tell
>    evolution not to mangle inline patches.
