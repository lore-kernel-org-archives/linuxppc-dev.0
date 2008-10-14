Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7EAB0DDF4F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 12:48:43 +1100 (EST)
Date: Mon, 13 Oct 2008 18:48:17 -0700 (PDT)
Message-Id: <20081013.184817.87272235.davem@davemloft.net>
To: bunk@kernel.org
Subject: Re: [2.6 patch] export genphy_restart_aneg
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081013171900.GK29938@cs181140183.pp.htv.fi>
References: <20081013171900.GK29938@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, afleming@freescale.com,
	jgarzik@pobox.com, buytenh@marvell.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 13 Oct 2008 20:19:00 +0300

> This patch fixes the following build error caused by
> commit ed94493fb38a665cebcf750dfabe8a6dd13e136f
> (mv643xx_eth: convert to phylib):

Applied, th anks Adrian.
