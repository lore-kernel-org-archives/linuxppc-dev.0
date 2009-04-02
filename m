Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AC3AADDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 19:28:24 +1100 (EST)
Date: Thu, 02 Apr 2009 01:28:13 -0700 (PDT)
Message-Id: <20090402.012813.163966172.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] fsl_pq_mdio: Revive UCC MDIO support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090331183352.GA4474@oksana.dev.rtsoft.ru>
References: <20090331183352.GA4474@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, afleming@freescale.com,
	Joakim.Tjernlund@transmode.se, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 31 Mar 2009 22:33:52 +0400

> commit 1577ecef766650a57fceb171acee2b13cbfaf1d3 ("netdev: Merge UCC
> and gianfar MDIO bus drivers") introduced a regression so that UCC
> MDIO buses no longer work.
> 
> This is because fsl_pq_mdio driver wrongly masks all non-TBI PHYs
> for !fsl,gianfar-mdio buses, while it should do that only for
> fsl,gianfar-tbi buses.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks.
