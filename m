Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMJxJ4gxSzF0hX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 07:44:49 +1100 (AEDT)
Date: Wed, 17 Jan 2018 15:44:45 -0500 (EST)
Message-Id: <20180117.154445.283511690122382070.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: fs_enet: do not call phy_stop() in interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180116093305.A04A26EEC5@localhost.localdomain>
References: <20180116093305.A04A26EEC5@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 16 Jan 2018 10:33:05 +0100 (CET)

> In case of TX timeout, fs_timeout() calls phy_stop(), which
> triggers the following BUG_ON() as we are in interrupt.
 ...
> This patch moves fs_timeout() actions into an async worker.
> 
> Fixes: commit 48257c4f168e5 ("Add fs_enet ethernet network driver, for several embedded platforms")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied, thank you.
