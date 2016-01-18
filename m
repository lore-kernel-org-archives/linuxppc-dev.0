Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDC7F1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 02:15:08 +1100 (AEDT)
Date: Mon, 18 Jan 2016 16:15:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shaohui Xie <shaohui.xie@nxp.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "shh.xie@gmail.com" <shh.xie@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Message-ID: <20160118151500.GD923@lunn.ch>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
 <20160114164418.GD19773@lunn.ch>
 <VI1PR04MB166491DEBB439EB72742201DE8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <56997951.90304@gmail.com> <5699B211.5070602@gmail.com>
 <VI1PR04MB16645A2F24DB515D86136BE2E8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <569C9CD2.10301@gmail.com>
 <VI1PR04MB1664AB0E483F01F1641059FFE8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR04MB1664AB0E483F01F1641059FFE8C00@VI1PR04MB1664.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> [S.H] the fsl backplane, e.g. 10GBASE-KR, needs software to handle link training,
> It's to train link partner, and trained by link partner parallel.
> 
> But if media type is not copper, e.g. optical module, we won't need this.

So what we actually need to know is copper vs fibre?

   Andrew
