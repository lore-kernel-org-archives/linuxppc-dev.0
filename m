Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 17E2BDDECE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 16:38:21 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l285cHYM003832
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 22:38:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l285cFRR019682
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 23:38:16 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 13:38:14 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
In-Reply-To: <011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In fact, I've included <asm-generic/rtc.h> in mpc86xx_hpcn.c file, and
the file linux/mc146818rtc.h was included in asm-generic/rtc.h.

Thanks!
Zhang Wei

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, March 08, 2007 10:47 AM
> To: Zhang Wei-r63237
> Cc: Wood Scott-B07421; Loeliger Jon-LOELIGER; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
>=20
>=20
> On Mar 7, 2007, at 7:56 PM, Zhang Wei-r63237 wrote:
>=20
> > Hi, Kumar and Scott,
> >
> > Thanks for your review. :-)
> >
> > The MPC8641HPCN's RTC is a module of ULI1575, which is a legacy RTC
> > device with operate by I/O ports 0x70 and 0x71. So I use functions
> > defined in asm-generic/rtc.h to set and get rtc time.
>=20
> Than you need to include <linux/mc146818rtc.h> in the file to=20
> get the =20
> CMOS_* defn.
>=20
> - k
>=20
>=20
>=20
