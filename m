Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7FAA6DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 12:52:05 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l291q0As020345
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 18:52:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l291pxeI020775
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 19:52:00 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Fri, 9 Mar 2007 09:51:57 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C131B07@zch01exm26.fsl.freescale.net>
In-Reply-To: <82D7F244-A949-4DC9-8DE3-A91DD25CD50A@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
	<1173381017.23776.211.camel@ld0161-tx32>
	<1173381543.2968.10.camel@udp097531uds.am.freescale.net>
	<82D7F244-A949-4DC9-8DE3-A91DD25CD50A@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Wang Haiying-r54964" <Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please use 80.
We reserve the first 16 ints for legacy 8259 interrupts. And we want the
virq is the same value to hw-irq.

Thanks!
Zhang Wei

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, March 09, 2007 3:25 AM
> To: Wang Haiying-r54964
> Cc: Loeliger Jon-LOELIGER; linuxppc-dev@ozlabs.org; Zhang Wei-r63237
> Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
>=20
>=20
> On Mar 8, 2007, at 1:19 PM, Haiying Wang wrote:
>=20
> >> And we're to change the NR_IRQS-10 to a hard 64 as well, right?
> >>
> > If we need change to hard value here, we should use 80 instead 64
> > because there are 16 interrupt sources for 8259, 48 for internal, =20
> > 12 for
> > external.
>=20
> but the 16 interrupts for 8259 have nothing to do with how many you =20
> allocate for MPIC.  64 is the number of MPIC interrupts (48 int + 12 =20
> ext =3D 60).  I say 64 because of how the register addresses.
>=20
> - k
>=20
