Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id DE5461A0A3F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 09:07:18 +1000 (EST)
Date: Thu, 07 Aug 2014 16:07:13 -0700 (PDT)
Message-Id: <20140807.160713.557740387140282430.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] net: fs_enet: fix reference counting for phy_node
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407445560-20500-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407445560-20500-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: f.fainelli@gmail.com, vbordug@ru.mvista.com, netdev@vger.kernel.org,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Date: Thu,  7 Aug 2014 23:06:00 +0200

> Make sure that fs_enet_probe is left with a reference to the phy node=
.=

> In the presence of a phy handle this is already the case as
> of_parse_phandle returns a reference. In the fixed phy case a call to=

> of_node_get is necessary. Otherwise the error path and remove functio=
n
> drop a reference the driver isn't holding.
> =

> Fixes: bb74d9a4a87b ("fs_enet: use the new fixed PHY helpers")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied.
