Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 562DA1A0A4B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 09:07:31 +1000 (EST)
Date: Thu, 07 Aug 2014 16:07:29 -0700 (PDT)
Message-Id: <20140807.160729.547343802808631351.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 3/3] net: ucc_geth: Don't use the MAC as PHY without a
 fixed link
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407448106-1819-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1407448106-1819-3-git-send-email-u.kleine-koenig@pengutronix.de>
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
Date: Thu,  7 Aug 2014 23:48:26 +0200

> This matches what the other drivers using fixed-link support do and
> restores the behaviour before commit 87009814cdbb ("ucc_geth: use the=

> new fixed PHY helpers") for the affected device trees (i.e. no
> phy-handle and no fixed-link).
> =

> Fixes: 87009814cdbb ("ucc_geth: use the new fixed PHY helpers")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied.
