Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A188CDDF1A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:55:23 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6GLtIJT008329
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 14:55:18 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6GLtINK025231
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 16:55:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH 6/8] Walnut DTS
Date: Mon, 16 Jul 2007 14:55:21 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA303067256@az33exm25.fsl.freescale.net>
In-Reply-To: <1184622446.25235.89.camel@localhost.localdomain>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[snip]
> There is no child device node, but there are child interrupt=20
> nodes, and
> since the interrupt-tree uses #address/size-cells, it does make some
> sense to specify them.
>=20
> Yes, there is a default value when absent, but the simple=20
> fact that the
> default is different depending if you are doing a device walk or an
> interrupt tree walk is very confusing. As I said above, the default
> values are a source of more problem than anything else and I tend to
> think they should be banned.
>=20
> I would personally be inclined to define that whatever spec we come up
> with always require #address-cells/#size-cells for any node that can
> have either device children or interrupt children, and ban default
> values alltogether.

Did you really mean #size-cells here?  Shouldn't it be #interrupt-cells?

Stuart
