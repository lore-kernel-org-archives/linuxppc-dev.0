Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1804CDDF1C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 20:33:05 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l179X4g7001433
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 02:33:04 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l179X1lJ025307
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 03:33:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Wed, 7 Feb 2007 17:34:18 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D4332@zch01exm26.fsl.freescale.net>
In-Reply-To: <001EB06E-FC1D-4F0A-A910-8E08EE0B8CE2@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Feb 6, 2007, at 5:31 AM, Li Yang wrote:
>=20
> > Get rid of private immrbar_virt_to_phys() routine and
> > use generic iopa().
>=20
> Nack. iopa() isn't that generic, shouldn't we really be using the dma
> mapping API here?

Do you mean the dma_map_single()?  dma_map_single can map memory space
correctly, but I don't think it can handle ioremap-ed space.

- Leo
