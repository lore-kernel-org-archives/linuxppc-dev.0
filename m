Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0085.outbound.protection.outlook.com [157.56.112.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 281FB1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 15:03:29 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Rob Herring <robh@kernel.org>, "shh.xie@gmail.com" <shh.xie@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Shaohui
 Xie" <Shaohui.Xie@freescale.com>
Subject: RE: [PATCH 2/3] [v2] powerpc: fsl: update fman dt binding for PCS PHY
Date: Fri, 15 Jan 2016 04:03:22 +0000
Message-ID: <VI1PR04MB1664E081AEA03DE388AF6202E8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1452760038-12442-1-git-send-email-shh.xie@gmail.com>
 <20160115025341.GA13316@rob-hp-laptop>
In-Reply-To: <20160115025341.GA13316@rob-hp-laptop>
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

> > +  - fsl-lane-handle: phandle, specifies a reference to a node represen=
ting a
> Serdes.
> > +  - fsl-lane-reg: offset and length of the register set for the serdes=
 lane.
>=20
> These should be fsl,... not fsl-...
Will fix it.

Thank you!

 Shaohui
