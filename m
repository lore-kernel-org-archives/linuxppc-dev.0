Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tT6Zh6rCbzDvnY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:17:32 +1100 (AEDT)
Date: Tue, 29 Nov 2016 23:17:21 -0500 (EST)
Message-Id: <20161129.231721.971587311467577164.davem@davemloft.net>
To: johan@kernel.org
Cc: vbridger@opensource.altera.com, f.fainelli@gmail.com,
 fugang.duan@nxp.com, pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 claudiu.manoil@freescale.com, leoli@freescale.com,
 thomas.petazzoni@free-electrons.com, nbd@openwrt.org, blogic@openwrt.org,
 matthias.bgg@gmail.com, sergei.shtylyov@cogentembedded.com,
 lars.persson@axis.com, mugunthanvnm@ti.com, grygorii.strashko@ti.com,
 robh+dt@kernel.org, frowand.list@gmail.com, andrew@lunn.ch,
 vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net 00/16] net: fix fixed-link phydev leaks
From: David Miller <davem@davemloft.net>
In-Reply-To: <1480357509-28074-1-git-send-email-johan@kernel.org>
References: <1480357509-28074-1-git-send-email-johan@kernel.org>
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

From: Johan Hovold <johan@kernel.org>
Date: Mon, 28 Nov 2016 19:24:53 +0100

> This series fixes failures to deregister and free fixed-link phydevs
> that have been registered using the of_phy_register_fixed_link()
> interface.
> 
> All but two drivers currently fail to do this and this series fixes most
> of them with the exception of a staging driver and the stmmac drivers
> which will be fixed by follow-on patches.
> 
> Included are also a couple of fixes for related of-node leaks.
> 
> Note that all patches except the of_mdio one have been compile-tested
> only.
> 
> Also note that the series is against net due to dependencies not yet in
> net-next.

Series applied, thanks Johan.
