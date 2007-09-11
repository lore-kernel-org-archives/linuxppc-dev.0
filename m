Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77D6DDDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 20:07:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8BA7D1B024935
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:07:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8BA7CYj018028
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:07:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/5] Add Freescale DMA engine driver maintainer.
Date: Tue, 11 Sep 2007 18:07:11 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D61D@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070910032737.GB27828@localhost.localdomain>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<11891624382764-git-send-email-wei.zhang@freescale.com>
	<20070910032737.GB27828@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'll merge them.

Thanks!=20
- zw

> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Monday, September 10, 2007 11:28 AM
> To: Zhang Wei-r63237
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/5] Add Freescale DMA engine driver maintainer.
>=20
> On Fri, Sep 07, 2007 at 06:53:53PM +0800, Zhang Wei wrote:
> > This patch adds Freescale DMA engine driver maintainer.
>=20
> This is meaningless without the actual driver, so it shouldn't be a
> separate patch.  Fold it into the patch that actually adds the driver
> support.
>=20
> --=20
> David Gibson			| I'll have my music baroque,=20
> and my code
> david AT gibson.dropbear.id.au	| minimalist, thank=20
> you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
>=20
