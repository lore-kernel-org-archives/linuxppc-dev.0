Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CC0BDDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 18:24:39 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m1I7OXn5008162
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:24:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1I7OWU5007520
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 01:24:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/6] Add OF-tree support to RapidIO controller driver.
Date: Mon, 18 Feb 2008 15:24:30 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEC3DEF3@zch01exm26.fsl.freescale.net>
In-Reply-To: <4A9328DB-F68C-4C09-B762-44FEA85DD12E@kernel.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<12016890832943-git-send-email-wei.zhang@freescale.com>
	<20080205164425.b6af5bff.sfr@canb.auug.org.au>
	<4A9328DB-F68C-4C09-B762-44FEA85DD12E@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
>=20
>=20
> On Feb 4, 2008, at 11:44 PM, Stephen Rothwell wrote:
>=20
> >>
> >> +	aw =3D *(u32 *)of_get_property(dev->node, "#address-cells", =
NULL);
> >> +	sw =3D *(u32 *)of_get_property(dev->node, "#size-cells", NULL);
> >
> > What happens if either of these properties is missing?
>=20
> Should we add __must_check to of_get_property?
>=20

You are right, I'll add the checking here.

Thanks!
Wei.
