Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E9B0DDE2D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 15:16:00 +1100 (EST)
Date: Thu, 08 Feb 2007 13:15:06 +0900 (JST)
Message-Id: <200702080415.l184FD0I011703@toshiba.co.jp>
Subject: Re: [PATCH] spidernet : fix memory leak in spider_net_stop
To: jeff@garzik.org
In-Reply-To: <45C33DED.8010200@garzik.org>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jim@jklewis.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff-san,

> Jens Osterkamp wrote:
> > We forget to call spider_net_free_rx_chain_contents which does the
> > actual dev_kfree_skb. New skbs are allocated from skbuff_head_cache
> > on each "ifconfig up" letting the cache grow infinitely.
> > 
> > This patch fixes it.
> > 
> > Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> 
> applied

This fix was applied twice to netdev-2.6.git#upstream.
Because Linas-san's patch has been applied to netdev-2.6.git#upstream.

Best regards,
Kou Ishizaki
