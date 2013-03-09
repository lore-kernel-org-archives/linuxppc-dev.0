Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id C31B82C0328
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 08:11:39 +1100 (EST)
Date: Sat, 09 Mar 2013 16:11:42 -0500 (EST)
Message-Id: <20130309.161142.153533460204187265.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH net-next] drivers:net: Remove unnecessary OOM messages
 after netdev_alloc_skb
From: David Miller <davem@davemloft.net>
In-Reply-To: <6379afbec3439c45180956b06c13b02ce3c9f802.1362790535.git.joe@perches.com>
References: <6379afbec3439c45180956b06c13b02ce3c9f802.1362790535.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 uclinux-dist-devel@blackfin.uclinux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Fri,  8 Mar 2013 17:03:25 -0800

> Emitting netdev_alloc_skb and netdev_alloc_skb_ip_align OOM
> messages is unnecessary as there is already a dump_stack
> after allocation failures.
> 
> Other trivial changes around these removals:
> 
> Convert a few comparisons of pointer to 0 to !pointer.
> Change flow to remove unnecessary label.
> Remove now unused variable.
> Hoist assignment from if.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
