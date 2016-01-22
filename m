Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 795271A0019
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 01:38:21 +1100 (AEDT)
Date: Fri, 22 Jan 2016 15:38:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shaohui Xie <shaohui.xie@nxp.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "shh.xie@gmail.com" <shh.xie@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Message-ID: <20160122143812.GP9991@lunn.ch>
References: <VI1PR04MB16645A2F24DB515D86136BE2E8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <569C9CD2.10301@gmail.com>
 <VI1PR04MB1664AB0E483F01F1641059FFE8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <20160118151500.GD923@lunn.ch>
 <VI1PR04MB1664DFBC53F08C5CE7EBF22AE8C10@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <20160121211250.GK9991@lunn.ch>
 <VI1PR04MB1664BAFB4EE494CB14830BCCE8C40@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <56A1F5AB.6090606@gmail.com>
 <VI1PR04MB1664AD70D26C452F5A33595AE8C40@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <VI1PR04MB1664B669925ADB21D3A13594E8C40@VI1PR04MB1664.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR04MB1664B669925ADB21D3A13594E8C40@VI1PR04MB1664.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The reason I mentioned maybe I should put the backplane property in
> fsl's binding is because the backplane implementation is really
> vendor specific, it's heavily relay how hardware implements the
> feature, maybe another vendor's hardware only needs a boolean
> property for driver to tell it should work in backplane, hardware
> can deal with different modes, or even no any special property
> needed if the hardware is strong enough to handle any connections, I
> cannot assume.  But I know what fsl's hardware needs to support
> backplane.

This is the key point really. We don't really care about the Freescale
PCS. We want a generic solution for 1000BASE-KX and 10GBASE-KR,
independent of who makes it, Marvell, Micrel, Broadcom, or Acme.

So, what generic properties are needed for 1000BASE-KX and 10GBASE-KR?
Properties that most/all manufactures are likely to need?

	   Andrew
