Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F86DB6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 10:57:21 +1000 (EST)
Date: Wed, 02 May 2012 20:53:12 -0400 (EDT)
Message-Id: <20120502.205312.1917428334537687075.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] net/pasemi: fix compiler warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120503105146.83f0a4a074dafad0443b875d@canb.auug.org.au>
References: <20120503105146.83f0a4a074dafad0443b875d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: olof@lixom.net, netdev@vger.kernel.org, netdev@pradeepdalvi.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 3 May 2012 10:51:46 +1000

> Fix this compiler warning (on PowerPC) by not marking a parameter as
> const:
> 
> drivers/net/ethernet/pasemi/pasemi_mac.c: In function 'pasemi_mac_replenish_rx_ring':
> drivers/net/ethernet/pasemi/pasemi_mac.c:646:3: warning: passing argument 1 of 'netdev_alloc_skb' discards qualifiers from pointer target type
> include/linux/skbuff.h:1706:31: note: expected 'struct net_device *' but argument is of type 'const struct net_device *'
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Pradeep A. Dalvi <netdev@pradeepdalvi.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks.
