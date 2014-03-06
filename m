Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id D91BD2C030A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 12:45:54 +1100 (EST)
Date: Wed, 05 Mar 2014 20:45:50 -0500 (EST)
Message-Id: <20140305.204550.930739914330776862.davem@davemloft.net>
To: shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] net/mlx4: Support shutdown() interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <1393918520-3268-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1393918520-3268-1-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, weiyang@linux.vnet.ibm.com, amirv@mellanox.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue,  4 Mar 2014 15:35:20 +0800

> In kexec scenario, we failed to load the mlx4 driver in the
> second kernel because the ownership bit was hold by the first
> kernel without release correctly.
> 
> The patch adds shutdown() interface so that the ownership can
> be released correctly in the first kernel. It also helps avoiding
> EEH error happened during boot stage of the second kernel because
> of undesired traffic, which can't be handled by hardware during
> that stage on Power platform.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Tested-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Applied.
