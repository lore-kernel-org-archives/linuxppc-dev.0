Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A501F67A70
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 08:23:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 29 Apr 2005 17:23:12 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85937C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"Kumar Gala" <kumar.gala@freescale.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
	thestock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The patch works on MPC8266ADS board using PQ2FADS setup with a couple of
hacks to disable some stuff the PQ2 has that the 8266ADS doesn't

> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
> Sent: Friday, April 29, 2005 06:29
> To: Kumar Gala
> Cc: Rune Torgersen; Wolfgang Denk; Tom Rini; linuxppc-embedded list
> Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge=20
> support to thestock linux-2.5 (updated)
>=20
> Kumar,
>=20
> This is what currently intended to represent on-chip PCI=20
> bridge support=20
> for PQ2 family.
> It's approved working on my 8272 and have a very good probably of the=20
> same on the PQ2FADS-VR board. It contains low-level (SIUMCR & CPLD IC=20
> chip select ) setup only for 8272 and PQ2FADS, considering=20
> that u-boot=20
> does this stuff for 8266 boards. The actual source files are=20
> renamed to=20
> m82xx_pci.[ch].
>=20
> Rune, can you test this for m8266/8265 ? I guess while IRQ stuff is=20
> nearly the same, this _should_ work as is or with minimum=20
> effort. Note=20
> that you'll need to define PCI_INT_TO_SIU in platforms/pq2ads.h (I=20
> suppose it's the same as PQ2FADS - SIU_INT_IRQ6,  but I'm not sure).
>=20
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>=20
> --=20
> Sincerely,=20
> Vitaly
>=20
>=20
