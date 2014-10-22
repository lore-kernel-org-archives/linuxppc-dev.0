Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id EC52B1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 06:34:13 +1100 (AEDT)
Date: Wed, 22 Oct 2014 15:33:39 -0400 (EDT)
Message-Id: <20141022.153339.553009019191281217.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Subject: Re: [PATCH] net: fs_enet: set back promiscuity mode after restart
From: David Miller <davem@davemloft.net>
In-Reply-To: <20141022070547.83AAB1A5E63@localhost.localdomain>
References: <20141022070547.83AAB1A5E63@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, germain.montoies@c-s.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 22 Oct 2014 09:05:47 +0200 (CEST)

> After interface restart (eg: after link disconnection/reconnection), the bridge
> function doesn't work anymore. This is due to the promiscuous mode being cleared
> by the restart.
> 
> The mac-fcc already includes code to set the promiscuous mode back during the restart.
> This patch adds the same handling to mac-fec and mac-scc.
> 
> Tested with bridge function on MPC885 with FEC.
> 
> Reported-by: Germain Montoies <germain.montoies@c-s.fr>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied, thanks.
