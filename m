Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 4548E1A0A1C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 08:13:23 +1100 (AEDT)
Date: Wed, 04 Feb 2015 13:13:20 -0800 (PST)
Message-Id: <20150204.131320.2283837573385701111.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Subject: Re: [PATCH] net: fs_enet: Implement NETIF_F_SG feature
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150202170654.D5EE21A5E90@localhost.localdomain>
References: <20150202170654.D5EE21A5E90@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Mon,  2 Feb 2015 18:06:54 +0100 (CET)

> Freescale ethernet controllers have the capability to re-assemble fragmented
> data into a single ethernet frame. This patch uses this capability and
> implements NETIP_F_SG feature into the fs_enet ethernet driver.
> 
> On a MPC885, I get 53% performance improvement on a ftp transfer of a 15Mb file:
>   * Without the patch : 2,8 Mbps
>   * With the patch : 4,3 Mbps
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied, thanks.
