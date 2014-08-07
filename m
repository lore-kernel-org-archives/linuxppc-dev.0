Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 2ABAE1A0A42
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 09:07:21 +1000 (EST)
Date: Thu, 07 Aug 2014 16:07:19 -0700 (PDT)
Message-Id: <20140807.160719.1981028891400963453.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 1/3] net: ucc_geth: drop acquired references in probe
 error path and remove
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Date: Thu,  7 Aug 2014 23:48:24 +0200

> The ucc_geth_probe function assigns to ug_info->tbi_node and
> ug_info->phy_node a value returned by of_parse_phandle which returns =
a
> new reference. Put this reference again in the error path of
> ucc_geth_probe and when removing the device.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied.
