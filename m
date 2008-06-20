Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92478DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 19:47:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5K9lq2H012602
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 02:47:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5K9loPK015668
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 04:47:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] fix mpc83xx spi prescale modulus calculate
Date: Fri, 20 Jun 2008 17:47:47 +0800
Message-ID: <989B956029373F45A0B8AF0297081890025637E0@zch01exm26.fsl.freescale.net>
In-Reply-To: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
References: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
From: "Li Yang" <LeoLi@freescale.com>
To: "Chen Gong" <G.Chen@freescale.com>, <linuxppc-dev@ozlabs.org>
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
> On Behalf Of Chen Gong
> Sent: Friday, June 20, 2008 5:38 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Chen Gong
> Subject: [PATCH] fix mpc83xx spi prescale modulus calculate
>=20
> Signed-off-by: Chen Gong <g.chen@freescale.com>

I think you should at least cc David Brownell and SPI mailling list.

- Leo
