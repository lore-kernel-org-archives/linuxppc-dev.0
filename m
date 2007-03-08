Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A69F1DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 19:17:22 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l288HHrw003265
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 01:17:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l288HGXf026940
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 02:17:17 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 16:17:15 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C0DBEA9@zch01exm26.fsl.freescale.net>
In-Reply-To: <CFFA5AB3-1C2A-4928-AE40-5BA24694AB09@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE18@zch01exm26.fsl.freescale.net>
	<CFFA5AB3-1C2A-4928-AE40-5BA24694AB09@kernel.crashing.org>
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

Hi, Kumar,=20

> >
> > So I reduces it by 10 for IRQs reserved (leave 1 more space for
> > further).
>=20
> Why don't we set the number to 64 instead of NR_IRQS - 10.  This =20
> covers all the internal and external interrupts.
>=20

If you want to set the IRQ amount number, it should be 80 instead of 64.
But I think setting it to NR_IRQS-10 could give more space for MPIC.

Thanks!
Zhang Wei
