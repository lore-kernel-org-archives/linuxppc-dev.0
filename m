Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id F2D491A071A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:40:29 +1000 (EST)
Date: Sun, 10 Aug 2014 21:40:25 -0700 (PDT)
Message-Id: <20140810.214025.1717177470256485891.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] net: ucc_geth: fix build failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20140808.135237.120203200807493642.davem@davemloft.net>
 <1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Date: Sun, 10 Aug 2014 20:32:05 +0200

> My series to fix the reference counting of dt nodes introduced a buil=
d
> failure. Fix it.
> =

> Fixes: fa310789a488 ("net: ucc_geth: drop acquired references in prob=
e error path and remove")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.
