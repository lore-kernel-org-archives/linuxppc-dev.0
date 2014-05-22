Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id BCB6E1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 05:18:22 +1000 (EST)
Date: Thu, 22 May 2014 15:18:17 -0400 (EDT)
Message-Id: <20140522.151817.763033809324051260.davem@davemloft.net>
To: f.fainelli@gmail.com
Subject: Re: [PATCH net-next v2 0/9] net: of_phy_connect_fixed_link removal
From: David Miller <davem@davemloft.net>
In-Reply-To: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
References: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org,
 aida.mynzhasova@skitlab.ru, sergei.shtylyov@cogentembedded.com,
 netdev@vger.kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 claudiu.manoil@freescale.com, vbordug@ru.mvista.com, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 22 May 2014 09:47:42 -0700

> This patch set removes of_phy_connect_fixed_link() from the tree now that
> we have a better solution for dealing with fixed PHY (emulated PHY) devices
> for drivers that require them.
> 
> First two patches update the 'fixed-link' Device Tree binding and drivers to
> refere to it.
> 
> Patches 3 to 7 update the in-tree network drivers that use
> of_phy_connect_fixed_link()
> 
> Patch 8 removes of_phy_connect_fixed_link
> 
> Patch 9 removes the PowerPC code that parsed the 'fixed-link' property.
> 
> Patch 9 can be merged via the net-next tree if the PowerPC folks ack it,
> but it really has to be merged after the first 8 patches in order to avoid
> breakage.

Series applied, if someone doesn't like patch #9 we can fix it up with a
followup patch or revert.
