Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5B15DDE3B6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:52:29 +1100 (EST)
Date: Mon, 13 Oct 2008 11:52:05 -0700 (PDT)
Message-Id: <20081013.115205.31287539.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [2.6 patch] export genphy_restart_aneg
From: David Miller <davem@davemloft.net>
In-Reply-To: <5281FCAB-128C-4AE7-8241-BF748B1911CF@freescale.com>
References: <20081013171900.GK29938@cs181140183.pp.htv.fi>
	<5281FCAB-128C-4AE7-8241-BF748B1911CF@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: bunk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, buytenh@marvell.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Mon, 13 Oct 2008 13:04:30 -0500

> 
> On Oct 13, 2008, at 12:19, Adrian Bunk wrote:
> 
> > This patch fixes the following build error caused by
> > commit ed94493fb38a665cebcf750dfabe8a6dd13e136f
> > (mv643xx_eth: convert to phylib):
> >
> > <--  snip  -->
> >
> > ...
> >  Building modules, stage 2.
> >  MODPOST 1280 modules
> > ERROR: "genphy_restart_aneg" [drivers/net/mv643xx_eth.ko] undefined!
> > ...
> > make[2]: *** [__modpost] Error 1
> >
> > <--  snip  -->
> >
> >
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> 
> Could you get genphy_setup_forced, too?  It doesn't appear to be used, but it's currently in include/linux/phy.h, and not static.

When there is a use we can add the export.
