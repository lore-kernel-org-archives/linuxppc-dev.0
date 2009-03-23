Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 41AC9DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 15:31:35 +1100 (EST)
Date: Sun, 22 Mar 2009 21:31:22 -0700 (PDT)
Message-Id: <20090322.213122.199224311.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2.6.29] ucc_geth: Fix oops when using fixed-link support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090320223417.GA20018@oksana.dev.rtsoft.ru>
References: <20090320223417.GA20018@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, leoli@freescale.com,
	Joakim.Tjernlund@transmode.se, Haiying.Wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Sat, 21 Mar 2009 01:34:17 +0300

> commit b1c4a9dddf09fe99b8f88252718ac5b357363dc4 ("ucc_geth: Change
> uec phy id to the same format as gianfar's") introduced a regression
> in the ucc_geth driver that causes this oops when fixed-link is used:
> 
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc0151270
...
> Reported-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Tested-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Applied, thanks.
