Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZqhz1Tm1zDrDV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 01:29:06 +1100 (AEDT)
Date: Mon, 5 Feb 2018 15:29:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: PA Semi PWRficient Gigabit Ethernet doesn't work anymore since
 the first networking updates for the kernel 4.16
Message-ID: <20180205142901.GD11811@lunn.ch>
References: <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com>
 <20180119132251.GJ32299@lunn.ch>
 <9e8e906d-b2b7-f11c-30ed-ccdf91ac563c@xenosoft.de>
 <20180204171626.GE10544@lunn.ch>
 <93dcb6c1-75d5-539c-c867-09266d43dbd0@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93dcb6c1-75d5-539c-c867-09266d43dbd0@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2018 at 10:38:34AM +0100, Christian Zigotzky wrote:
> Hello Andrew,
> 
> Many thanks for your patch. I compiled the latest git kernel today and the
> PA Semi PWRficient Gigabit Ethernet works with your patch.

Great.

Can i add a tested-by:

Thanks
	Andrew
