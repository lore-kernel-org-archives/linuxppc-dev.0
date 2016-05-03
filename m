Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qznZh1btKzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 03:04:12 +1000 (AEST)
Date: Tue, 03 May 2016 13:04:09 -0400 (EDT)
Message-Id: <20160503.130409.602030242618132160.davem@davemloft.net>
To: tremyfr@gmail.com
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 claudiu.manoil@freescale.com, leoli@freescale.com, treding@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] net: ethernet: ucc: move to new ethtool api
 {get|set}_link_ksettings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1462115291-11372-2-git-send-email-tremyfr@gmail.com>
References: <1462115291-11372-1-git-send-email-tremyfr@gmail.com>
 <1462115291-11372-2-git-send-email-tremyfr@gmail.com>
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

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sun,  1 May 2016 17:08:09 +0200

> The ethtool api {get|set}_settings is deprecated.
> We move the ucc driver to new api {get|set}_link_ksettings.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
