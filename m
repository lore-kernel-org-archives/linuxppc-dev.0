Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og115.obsmtp.com (exprod7ob115.obsmtp.com [64.18.2.216])
	by ozlabs.org (Postfix) with SMTP id 74ED3DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Dec 2008 07:48:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB Host support on mpc 8313
Date: Sun, 30 Nov 2008 12:47:06 -0800
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B60875AD47@SJEXCH03.ds.jdsu.net>
In-Reply-To: <113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
References: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>
	<113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
To: "Li Yang" <LeoLi@freescale.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

That was exactly my problem.  You guys at freescale rock.

- Joaquin Luna

-----Original Message-----
From: Li Yang [mailto:LeoLi@freescale.com]=20
Sent: Monday, November 24, 2008 2:12 AM
To: Joaquin Luna; linuxppc-embedded@ozlabs.org
Subject: RE: USB Host support on mpc 8313

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
