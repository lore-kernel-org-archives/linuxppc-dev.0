Return-Path: <Vivek.Mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96BDDB7BCA
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 18:15:32 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n957FSWP009940
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 00:15:29 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n957Hemg017323
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 02:17:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 4/4] powerpc/fsl: 85xx: add cache-sram support
Date: Mon, 5 Oct 2009 12:45:25 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08FF6268@zin33exm23.fsl.freescale.net>
In-Reply-To: <49156378-9156-4059-99C2-57E2815473BD@freescale.com>
References: <1253783426-11978-1-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-2-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-3-git-send-email-vivek.mahajan@freescale.com>
	<1253783426-11978-4-git-send-email-vivek.mahajan@freescale.com>
	<49156378-9156-4059-99C2-57E2815473BD@freescale.com>
From: "Mahajan Vivek-B08308" <Vivek.Mahajan@freescale.com>
To: "Gala Kumar-B11780" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Gala Kumar-B11780=20
> Sent: Friday, September 25, 2009 12:08 AM
> > +	mbar(1);
>=20
> why isn't eieio() sufficient here?

When I initially added / tested cache SRAM for P2020RDB, its RM talked
about using mbar() though mbar(1) is identical to eieio() opcode-wise.
Also as cache-sram works only for 85xx derivatives, so I picked mbar()
instead of eieio.

Thanks,
Vivek
