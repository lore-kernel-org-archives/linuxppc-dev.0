Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09120DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 23:11:44 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l64DBcET026565
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 06:11:39 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l64DBbMP016015
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 08:11:38 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] ucc_geth.c, make PHY device optional.
Date: Wed, 4 Jul 2007 21:13:32 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D839B4@zch01exm26.fsl.freescale.net>
In-Reply-To: <1183539047.20673.216.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

{snip}
>=20
> OK, but then a new property in PHY node is needed which holds
> the initial speed and duplex.
> initial-phy-capacity =3D <speed duplex> ?
> This should be useful for real PHYs too if, for instance, autoneg
isn't
> working/supported/wanted.
>=20
> Maybe it should be:
> initial-phy-capacity =3D <speed duplex autoneg>
> or
> initial-phy-capability =3D <speed duplex autoneg>

How about separate autoneg to a property "dumb-phy", which indicates the
PHY/switch doesn't provide MII register interface.  Therefore, it should
use the fixed speed and duplex from device node rather than registers.

- Leo
