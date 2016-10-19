Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3szZKL0zfjzDt4f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 01:37:25 +1100 (AEDT)
Date: Wed, 19 Oct 2016 10:37:19 -0400 (EDT)
Message-Id: <20161019.103719.1662715158720899418.davem@davemloft.net>
To: tklauser@distanz.ch
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] net: fs_enet: Use net_device_stats from struct net_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20161019092457.15006-1-tklauser@distanz.ch>
References: <20161019092457.15006-1-tklauser@distanz.ch>
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

From: Tobias Klauser <tklauser@distanz.ch>
Date: Wed, 19 Oct 2016 11:24:57 +0200

> Instead of using a private copy of struct net_device_stats in struct
> fs_enet_private, use stats from struct net_device. Also remove the now
> unnecessary .ndo_get_stats function.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to net-next, thanks.
