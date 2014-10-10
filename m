Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 324AC1A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 15:51:50 +1100 (EST)
Date: Fri, 10 Oct 2014 00:51:46 -0400 (EDT)
Message-Id: <20141010.005146.105821454500503183.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Subject: Re: [PATCH] net: fs_enet: error: 'SCCE_ENET_TXF' undeclared
From: David Miller <davem@davemloft.net>
In-Reply-To: <20141009145443.74AD61AB275@localhost.localdomain>
References: <20141009145443.74AD61AB275@localhost.localdomain>
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
Date: Thu,  9 Oct 2014 16:54:43 +0200 (CEST)

> [linux-devel:devel-hourly-2014100909 3763/3915] drivers/net/ethernet/freescale/fs_enet/mac-scc.c:119:32: error: 'SCCE_ENET_TXF' undeclared
> 
> Due to patch d43a396 net: fs_enet: Add NAPI TX, it appears that some target
> compilations are broken.
> This is due to the fact that unlike the FEC, the SCC and FCC don't have a TXF
> event (complete Frame transmitted) but only TXB (buffer transmitted).
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied, thanks.
