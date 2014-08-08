Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id C717C1A0A7F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 06:52:43 +1000 (EST)
Date: Fri, 08 Aug 2014 13:52:37 -0700 (PDT)
Message-Id: <20140808.135237.120203200807493642.davem@davemloft.net>
To: u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 1/3] net: ucc_geth: drop acquired references in probe
 error path and remove
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140808203456.GB5134@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140808203456.GB5134@pengutronix.de>
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
Date: Fri, 8 Aug 2014 22:34:56 +0200

> @davem: Should I send a fixup or a new version?

Fixup, please.
