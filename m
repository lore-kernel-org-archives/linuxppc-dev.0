Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0096.outbound.protection.outlook.com [157.55.234.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FA1B1A0037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 16:00:44 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>, "shh.xie@gmail.com" <shh.xie@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Shaohui Xie
 <Shaohui.Xie@freescale.com>
Subject: RE: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Date: Tue, 19 Jan 2016 05:00:35 +0000
Message-ID: <VI1PR04MB1664DFBC53F08C5CE7EBF22AE8C10@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
 <20160114164418.GD19773@lunn.ch>
 <VI1PR04MB166491DEBB439EB72742201DE8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <56997951.90304@gmail.com> <5699B211.5070602@gmail.com>
 <VI1PR04MB16645A2F24DB515D86136BE2E8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <569C9CD2.10301@gmail.com>
 <VI1PR04MB1664AB0E483F01F1641059FFE8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <20160118151500.GD923@lunn.ch>
In-Reply-To: <20160118151500.GD923@lunn.ch>
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

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Monday, January 18, 2016 11:15 PM
> To: Shaohui Xie
> Cc: Sebastian Hesselbarth; Florian Fainelli; shh.xie@gmail.com;
> devicetree@vger.kernel.org; netdev@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; davem@davemloft.net; Shaohui Xie
> Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-=
KR
>=20
> > [S.H] the fsl backplane, e.g. 10GBASE-KR, needs software to handle
> > link training, It's to train link partner, and trained by link partner
> parallel.
> >
> > But if media type is not copper, e.g. optical module, we won't need thi=
s.
>=20
> So what we actually need to know is copper vs fibre?
Copper is not enough to indicate backplane, since backplane is always coppe=
r,
 but copper is not always backplane.

Thank you!
Shaohui
