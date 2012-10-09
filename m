Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id 4F5A12C00B0
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2012 15:30:33 +1100 (EST)
Date: Tue, 09 Oct 2012 00:21:51 -0400 (EDT)
Message-Id: <20121009.002151.1744939534508464049.davem@davemloft.net>
To: mikey@neuling.org
Subject: Re: net: fix typo in freescale/ucc_geth.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <23452.1349740345@neuling.org>
References: <20121008173653.1d17895964980c98af59c8ea@canb.auug.org.au>
 <23452.1349740345@neuling.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 edumazet@google.com, linux-next@vger.kernel.org, mbizon@freebox.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>
Date: Tue, 09 Oct 2012 10:52:25 +1100

> The following patch: 
>   acb600d net: remove skb recycling
> added dev_free_skb() to drivers/net/ethernet/freescale/ucc_geth.c
> 
> This is a typo and should be dev_kfree_skb().  This fixes this.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied, thanks a lot.
