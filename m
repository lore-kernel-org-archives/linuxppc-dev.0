Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D0398DDF9F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:46:35 +1100 (EST)
Date: Tue, 06 Jan 2009 16:46:35 -0800 (PST)
Message-Id: <20090106.164635.27664644.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] powerpc: cleanup from l64 to ll64 change: drivers/net
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090107114006.336cfad0.sfr@canb.auug.org.au>
References: <20090107114006.336cfad0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 7 Jan 2009 11:40:06 +1100

> These are powerpc specific drivers.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ehea/ehea_main.c |    8 ++++----
>  drivers/net/ehea/ehea_qmr.c  |   18 +++++++++---------
>  drivers/net/ibmveth.c        |   16 ++++++++--------
>  drivers/net/iseries_veth.c   |    2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
> 
> This patch on its own will generate several warnings - it depends on
> the actual l64 to ll64 patch that is pending in the powerpc queue.  It
> may be easier for someone to ack this and for it to actually be fed
> through the powerpc tree.

Feeding it through the powerpc tree works for me:

Acked-by: David S. Miller <davem@davemloft.net>
