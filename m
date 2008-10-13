Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D2DCDE6A5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:05:24 +1100 (EST)
Message-Id: <5281FCAB-128C-4AE7-8241-BF748B1911CF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20081013171900.GK29938@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [2.6 patch] export genphy_restart_aneg
Date: Mon, 13 Oct 2008 13:04:30 -0500
References: <20081013171900.GK29938@cs181140183.pp.htv.fi>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	Lennert Buytenhek <buytenh@marvell.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 13, 2008, at 12:19, Adrian Bunk wrote:

> This patch fixes the following build error caused by
> commit ed94493fb38a665cebcf750dfabe8a6dd13e136f
> (mv643xx_eth: convert to phylib):
>
> <--  snip  -->
>
> ...
>  Building modules, stage 2.
>  MODPOST 1280 modules
> ERROR: "genphy_restart_aneg" [drivers/net/mv643xx_eth.ko] undefined!
> ...
> make[2]: *** [__modpost] Error 1
>
> <--  snip  -->
>
>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>


Could you get genphy_setup_forced, too?  It doesn't appear to be used,  
but it's currently in include/linux/phy.h, and not static.

Alternatively, we could change genphy_setup_forced to be static.  :)

Andy
