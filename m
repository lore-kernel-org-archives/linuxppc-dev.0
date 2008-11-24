Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94C49DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 18:12:31 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAO7CODm003310 for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 00:12:25 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id mAO7CNtJ011363
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 01:12:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB Host support on mpc 8313
Date: Mon, 24 Nov 2008 15:12:23 +0800
Message-ID: <113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
In-Reply-To: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>
References: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>
From: "Li Yang" <LeoLi@freescale.com>
To: "Joaquin Luna" <Joaquin.Luna@jdsu.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o
> rg] On Behalf Of Joaquin Luna
> Sent: Monday, November 24, 2008 11:24 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: USB Host support on mpc 8313
>=20
> Is there anyone out there who has tried getting usb to work=20
> under the 2.6.27 kernel?  I am using the Freescale MPC831x=20
> RDB platform and when I enable "Support for Freescale on-chip=20
> EHCI USB controller" (USB_EHCI_FSL) I get stuck during boot=20
> up.  The last two lines of my boot log are:
>=20
> =20
>=20
> fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
>=20
> fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
>=20
> =20
>=20
> =20
>=20
> With the 2.6.20 kernel I had usb working and my boot log looked like:
>=20
> =20
>=20
> fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
>=20
> fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
>=20
> fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
>=20
> fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
>=20
> =20
>=20
> =20
>=20
> I did notice that there were a few usb bug fixes that went=20
> into 2.6.27.7 so I updated to the latest version, but it did=20
> not help.  Any idea how or where I can begin looking for a solution?


There are two settings of the board (USB internal PHY/ USB external
PHY).  They are described in the board UM.

Is the phy_type property in DTS matching the board setting?
utmi_wide for internal PHY
ulpi for external PHY

- Leo
