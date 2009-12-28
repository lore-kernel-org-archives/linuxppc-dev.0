Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BF8C2100896
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Dec 2009 16:55:02 +1100 (EST)
Date: Sun, 27 Dec 2009 21:55:04 -0800 (PST)
Message-Id: <20091227.215504.71112983.davem@davemloft.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 2/3] phylib: Properly reinitialize PHYs after hibernation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091222221451.GB9268@oksana.dev.rtsoft.ru>
References: <20091222221451.GB9268@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org,
	afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 23 Dec 2009 01:14:51 +0300

> Since hibernation assumes power loss, we should fully reinitialize
> PHYs (including platform fixups), as if PHYs were just attached.
> 
> This patch factors phy_init_hw() out of phy_attach_direct(), then
> converts mdio_bus to dev_pm_ops and adds an appropriate restore()
> callback.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
