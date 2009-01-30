Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E9BDBDDFC3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 12:31:36 +1100 (EST)
Date: Thu, 29 Jan 2009 17:31:33 -0800 (PST)
Message-Id: <20090129.173133.268065861.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] gianfar: Fix Wake-on-LAN support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090128203545.GA13928@oksana.dev.rtsoft.ru>
References: <20090128203545.GA13928@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org,
	jgarzik@pobox.com, peppe.cavallaro@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 28 Jan 2009 23:35:45 +0300

> commit 0f0ca340e57bd7446855fefd07a64249acf81223 ("phy: power
> management support") caused a regression in the gianfar driver.
> 
> Now phylib turns off PHY power during suspend, and thus WOL
> doesn't work anymore.
> 
> This patch workarounds the issue by enabling wakeup in the MDIO
> device, i.e. just restores the old behaviour for the gianfar
> driver. Note that this way all PHYs on a given MDIO bus won't
> be turned off during suspend, which isn't good from the power
> saving point of view.
> 
> A proper, per netdevice wakeup management support will need
> a bit reworked phylib suspend/resume logic.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks Anton.
