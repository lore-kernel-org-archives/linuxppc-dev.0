Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92F0FDDFB2
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:55:40 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0C7tLS9012464
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 00:55:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n0C7tJ4a006502
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 01:55:20 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB
	w/FSL U-Boots
Date: Mon, 12 Jan 2009 15:55:17 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
From: "Li Yang" <LeoLi@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Anton Vorontsov
> Sent: Sunday, January 11, 2009 11:30 PM
> To: Kumar Gala
> Cc: linuxppc-dev@ozlabs.org
> Subject: [PATCH] powerpc/83xx: Make serial ports work on=20
> MPC8315E-RDB w/FSL U-Boots
>=20
> FSL U-Boots use /soc8315@e0000000 node to search and fixup=20
> serial nodes' clock-frequency properties. Though in upstream=20
> kernels we use new naming convention -- for IMMR address=20
> space dts files specify /immr@e0000000 nodes.
>=20
> This makes FSL U-Boots fail to fixup the clock frequencies,=20
> and that leads to serial ports misbehaviour. We can=20
> workaround the issue by filling the clock frequency values manually.

Freescale BSP is for customer who needs the out-of-box experience.  It's
better tested, but doesn't update very frequently.  I would suggest the
customer to use the upstream u-boot, if they decide to use latest
upstream kernel.

- Leo
