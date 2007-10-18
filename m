Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45CD2DDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:24:09 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9IEO3hV022355
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 07:24:04 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9IEO21t016617
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:24:03 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix ethernet multicast for ucc_geth.
Date: Thu, 18 Oct 2007 22:24:00 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5BD2@zch01exm26.fsl.freescale.net>
In-Reply-To: <1192611942.7848.19.camel@gentoo-jocke.transmode.se>
References: <1192611942.7848.19.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>, "Netdev" <netdev@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]=20
> Sent: Wednesday, October 17, 2007 5:06 PM
> To: Netdev; Li Yang-r58472
> Subject: [PATCH] Fix ethernet multicast for ucc_geth.
>=20
> >From 5761a9e5924b34615c748fba2dcb977ed04c1243 Mon Sep 17=20
> 00:00:00 2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Wed, 17 Oct 2007 11:01:44 +0200
> Subject: [PATCH] Fix ethernet multicast for ucc_geth.
>  hw_add_addr_in_hash() already swaps byte  order, don't do it=20
> in ucc_geth_set_multi() too.
>=20
>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Acked-by: Li Yang <leoli@freescale.com>
