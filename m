Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id D08C31A0A42
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 09:07:25 +1000 (EST)
Date: Thu, 07 Aug 2014 16:07:24 -0700 (PDT)
Message-Id: <20140807.160724.1353005428981700895.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 2/3] net: ucc_geth: make probe consistently acquire a
 reference to the phy node
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407448106-1819-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1407448106-1819-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, f.fainelli@gmail.com,
 kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Date: Thu,  7 Aug 2014 23:48:25 +0200

> When the driver attaches to a device that has a phy handle the probe
> routine returns with a reference to that node. This reference is
> correctly dropped in the error path and the remove function. In the
> fixed phy case however no reference is acquired and so the error path=

> might drop a reference the driver isn't holding. Fix that by getting =
a
> reference to the MAC.
> =

> Fixes: 87009814cdbb ("ucc_geth: use the new fixed PHY helpers")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied.
