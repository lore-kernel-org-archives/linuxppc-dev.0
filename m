Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCED1DDFBE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 23:12:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4TDClpV022602
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 06:12:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m4TDCikG024185
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 08:12:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Subject: RE: USB @ MPC834x
Date: Thu, 29 May 2008 21:12:43 +0800
Message-ID: <989B956029373F45A0B8AF02970818900250DA70@zch01exm26.fsl.freescale.net>
In-Reply-To: <483E7C73.3060701@matrix-vision.de>
References: <483E7C73.3060701@matrix-vision.de>
From: "Li Yang" <LeoLi@freescale.com>
To: "Andre Schwarz" <andre.schwarz@matrix-vision.de>,
	"Wood Scott" <scottwood@freescale.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Andre Schwarz [mailto:andre.schwarz@matrix-vision.de]=20
> Sent: Thursday, May 29, 2008 5:51 PM
> To: Wood Scott; Li Yang
> Cc: linux-ppc list
> Subject: USB @ MPC834x
>=20
> Scott, Li,
>=20
> I'm sorry to bother you again ... but after bringing up all=20
> parts of my
> MPC8343 based board the not working USB is the last pending problem.
> Actually I'm running on 2.6.25 with a custom board.
>=20
> Since USB is different for MPC8349/7/3 (depending on package) there
> _could_ be a configuration problem.
> Maybe you can help me out or give some hints at last.
>=20
> Situation:
> MPC8343A with ULPI-PHY (USB3300 from SMSC) connected the same=20
> way as on
> the Freescale "MPC8349EA_MDS_PB-TBGA" Board, i.e. using ULPI=20
> mode of the
> USB dual role module.
>=20
>=20
> Do you know if this PHY has ever been running on any Freescale board ?

Yes, this PHY is used on several reference boards.

> Do you know of _any_ MPC8343 based board running USB with an OTG PHY ?
> Or has it always been a 8349 thus having both ports available ?
>=20
>=20
> There are quite a few things that make me wonder :
>=20
> Regarding to MPC8343EA manual I only have DR_D0..D7 pins available for
> the DualRole module.
> The port is labeled "Port1" - it's the only one that is bonded inside
> the small package.
>=20
> On the Freescale schematics the pins DR_D0..D7 are labeld "Port0".

There is some confusion between the board port and chip port.  But as =
MPC8343/7/9 share the same UM, it should be the same as 8349.

- Leo
