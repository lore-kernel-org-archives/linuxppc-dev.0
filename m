Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3E4F4DDFCE
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 20:51:04 +1000 (EST)
Date: Wed, 03 Jun 2009 03:51:01 -0700 (PDT)
Message-Id: <20090603.035101.13573713.davem@davemloft.net>
To: Haiying.Wang@freescale.com
Subject: Re: [PATCH 2/4] fsl_pq_mido: Set the first UCC as the mii
	management interface master
From: David Miller <davem@davemloft.net>
In-Reply-To: <1243951456-4685-2-git-send-email-Haiying.Wang@freescale.com>
References: <1243951456-4685-1-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-2-git-send-email-Haiying.Wang@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Haiying Wang <Haiying.Wang@freescale.com>
Date: Tue,  2 Jun 2009 10:04:14 -0400

> Current code makes the UCC whose register range includes the current mdio
> register to be the MII managemnt interface master of the QE. If there is more
> than one mdio bus for QE, the UCC of the last mdio bus will be the MII
> management interface master which will make the primary mdio bus working
> unproperly, e.g. can not get the right clock. Normally the primary mdio bus is
> the first UEC's mdio bus.
> This patch allows the first UCC to be the MII management interface master of the
> multiple UCC mdio buses.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>

Applied to net-next-2.6
