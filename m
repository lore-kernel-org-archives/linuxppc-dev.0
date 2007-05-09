Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A57FFDDE2A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 11:18:35 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l491IU95022721
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 18:18:30 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l491IUuW020203
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:18:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Current powerpc.git build failures
Date: Tue, 8 May 2007 18:18:29 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C012AA6B2@az33exm24.fsl.freescale.net>
In-Reply-To: <20070509010941.GC4198@localhost.localdomain>
References: <20070508191758.GA26879@lixom.net>
	<4640DDD8.4040001@freescale.com><5E47D5F4-DD15-46D1-A947-3031D069486F@kernel.crashing.org>
	<20070509010941.GC4198@localhost.localdomain>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: jdl@jdl.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Olof Johansson <olof@lixom.net>, arnd@ardnb.de,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Looks like.  AFAICT, the generic nopud.h and nopmd.h headers expect
> page.h to be included before pgtable.h.  I think this patch should fix
> the problem, but I don't have a suitable board to test with.
>=20

That would be me.  I'll give it a spin.

Thanks,
Jdl
