Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1E765B7D5B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 20:45:31 +1000 (EST)
Date: Wed, 02 Jun 2010 03:45:40 -0700 (PDT)
Message-Id: <20100602.034540.73663475.davem@davemloft.net>
To: w.sang@pengutronix.de
Subject: Re: [PATCH] net/mpc52xx_phy: Various code cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <1274264470-2905-1-git-send-email-w.sang@pengutronix.de>
References: <1274264470-2905-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 19 May 2010 12:21:10 +0200

> - don't free bus->irq (obsoleted by ca816d98170942371535b3e862813b0aba9b7d90)
> - don't dispose irqs (should be done in of_mdiobus_register())
> - use fec-pointer consistently in transfer()
> - use resource_size()
> - cosmetic fixes
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Applied, thanks.
