Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s27.bay0.hotmail.com (bay0-omc2-s27.bay0.hotmail.com
	[65.54.246.163]) by ozlabs.org (Postfix) with ESMTP id 8377BDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 00:49:43 +1100 (EST)
Message-ID: <BLU106-W38B9242918AC024D3BEBB6CA820@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC5200B: Linux does not recognise the external PCI card
Date: Thu, 15 Nov 2007 14:49:41 +0100
In-Reply-To: <200711151430.05943.jbe@pengutronix.de>
References: <200711151430.05943.jbe@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> From: jbe@pengutronix.de
> To: linuxppc-embedded@ozlabs.org
> Date: Thu, 15 Nov 2007 14:30:05 +0100
> Subject: MPC5200B: Linux does not recognise the external PCI card
>=20
> Hi,

Hello,


> currently I'm trying to activate the PCI bus of my MPC5200B based card. U=
-Boot=20
> outputs:
>=20
> [...]
> PCI:   Bus Dev VenId DevId Class Int
>         00  18  1033  0035  0c03  00
>         00  18  1033  0035  0c03  00
>         00  18  1033  00e0  00e0  00
>         00  1a  1057  5809  0680  00
> [...]
>=20
> When I start Linux it outputs:
>=20
> [...]
> PCI: Probing PCI hardware
> PCI: device 0000:00:18.0 has unknown header type 7f, ignoring.
> mpc52xx_pci_fixup_resources() 1057:5809
> [...]
>=20
> and does not show the external card:

Which card? Is its driver supported by the kernel? Is it enabled inside the=
 kernel image?
Did you add the PCI bridge in platform configuration file? I suppose so if =
there is a PCI probing test.
I added an external ethernet device and had no problem to made it work with=
 2.6.22 kernel.

Pedro.

> # lspci -v
> 00:1a.0 Bridge: Motorola Unknown device 5809
>         Flags: bus master, 66MHz, medium devsel, latency 248
>         Memory at a0000000 (32-bit, non-prefetchable) [size=3D256K]
>         Memory at  (32-bit, prefetchable)
>=20
> Any idea what could cause this behavior?
> Could this be an oftree related issue? Or something hardware only related=
?
> The external slot is of 3.3V only type, running at 33 1/3 MHz.
>=20
> If it is an oftree issue, can someone point me to some kind of documentat=
ion,=20
> what data I must provide in the
> 	pci@0d00 {
> 		....
> 	}
> section?
>=20
> Juergen
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=
