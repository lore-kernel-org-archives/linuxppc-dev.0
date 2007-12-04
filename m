Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDB5EDDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 21:57:16 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lB4AvAo9027448
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 03:57:11 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lB4Av9nT027329
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 04:57:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] powerpc: Add IPIC MSI support
Date: Tue, 4 Dec 2007 18:57:07 +0800
Message-ID: <989B956029373F45A0B8AF029708189001B4D395@zch01exm26.fsl.freescale.net>
In-Reply-To: <1196764760.2573.10.camel@Guyver>
References: <1196764760.2573.10.camel@Guyver>
From: "Li Yang" <LeoLi@freescale.com>
To: "Li Tony" <Tony.Li@freescale.com>, "Gala Kumar" <kumar.gala@freescale.com>,
	"Phillips Kim" <Kim.Phillips@freescale.com>, <michael@ellerman.id.au>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Li Tony
> Sent: Tuesday, December 04, 2007 6:39 PM
> To: Gala Kumar; Phillips Kim; michael@ellerman.id.au; linuxppc-dev
> Subject: [PATCH 2/2] powerpc: Add IPIC MSI support
>=20
> Modified based on discussion on list.
>=20
> 1. Adopt virq_to_hw routine
> 2. Correct a legacy bug

The above lines should probably be placed after the "---" below.

>=20
> Implements the IPIC MSI as two level interrupt controller.
>=20
> Signed-off-by: Tony Li <tony.li@freescale.com>
> ---

- Leo
