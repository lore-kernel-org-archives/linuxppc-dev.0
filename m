Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vMnXr0kGBzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:12:41 +1100 (AEDT)
Date: Mon, 13 Feb 2017 22:12:34 -0500 (EST)
Message-Id: <20170213.221234.1010801525970370907.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] net: fs_enet: Fix an error handling path
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170210201706.16588-1-christophe.jaillet@wanadoo.fr>
References: <20170210201706.16588-1-christophe.jaillet@wanadoo.fr>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 10 Feb 2017 21:17:06 +0100

> 'of_node_put(fpi->phy_node)' should also be called if we branch to
> 'out_deregister_fixed_link' error handling path.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.
