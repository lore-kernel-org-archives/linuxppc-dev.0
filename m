Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id A9C452C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 06:22:50 +1000 (EST)
Date: Thu, 11 Apr 2013 16:22:45 -0400 (EDT)
Message-Id: <20130411.162245.954727103094202894.davem@davemloft.net>
To: sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 smoch@web.de, paulus@samba.org, linux-arm-kernel@lists.infradead.org,
 dale@farnsworth.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 florian@openwrt.org, buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Thu, 11 Apr 2013 14:40:23 +0200

> This patch adds GRO support to mv643xx_eth by making it invoke
> napi_gro_receive instead of netif_receive_skb.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Applied.
