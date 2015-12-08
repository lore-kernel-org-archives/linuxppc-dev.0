Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442531A0F25
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 22:20:37 +1100 (AEDT)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [v9, 3/6] fsl/fman: Add FMan MAC support
Date: Tue, 8 Dec 2015 11:20:28 +0000
Message-ID: <DM2PR03MB50977BE1FED436058110704E6080@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1449127157-9400-1-git-send-email-igal.liberman@freescale.com>
 <1449127157-9400-4-git-send-email-igal.liberman@freescale.com>
 <20151203.152342.830757781812463540.davem@davemloft.net>
In-Reply-To: <20151203.152342.830757781812463540.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Regards,
Igal Liberman

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Thursday, December 03, 2015 10:24 PM
> To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
> Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Wood Scott-B07421 <scottwood@freescale.com>;
> Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>;
> pebolle@tiscali.nl; joakim.tjernlund@transmode.se; ppc@mindchasers.com;
> stephen@networkplumber.org
> Subject: Re: [v9, 3/6] fsl/fman: Add FMan MAC support
>=20
> From: <igal.liberman@freescale.com>
> Date: Thu, 3 Dec 2015 09:19:14 +0200
>=20
> > +static u32 crc_table[256] =3D {
>=20
> No way.
>=20
> We have every conceivable implementation of CRC calculations in the kerne=
l
> already.  Use them.

OK, I will remove the private implementation of CRC calculation in the next=
 submission. Thank you.

Igal
