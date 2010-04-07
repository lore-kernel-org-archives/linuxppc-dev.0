Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 34DE3B7D0E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 12:52:03 +1000 (EST)
Date: Tue, 06 Apr 2010 19:52:04 -0700 (PDT)
Message-Id: <20100406.195204.165441511.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1270502993.9013.36.camel@edumazet-laptop>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: michal.simek@petalogix.com, netdev@vger.kernel.org, jtyner@cs.ucr.edu,
	linuxppc-dev@ozlabs.org, john.linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 05 Apr 2010 23:29:53 +0200

> So, I ask, cant you use netdev_alloc_skb_ip_align() in this driver ?

Thanks to everyone for getting this patch into shape.

I applied version 4 of the patch to net-next-2.6, thanks!
