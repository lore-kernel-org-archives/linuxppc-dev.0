Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A729EDDF92
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 19:25:46 +1100 (EST)
Date: Sun, 11 Jan 2009 00:25:45 -0800 (PST)
Message-Id: <20090111.002545.208618220.davem@davemloft.net>
To: timur@freescale.com
Subject: Re: [PATCH] ucc_geth: use correct UCCE macros
From: David Miller <davem@davemloft.net>
In-Reply-To: <1231359172-6119-1-git-send-email-timur@freescale.com>
References: <1231359172-6119-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>
Date: Wed,  7 Jan 2009 14:12:52 -0600

> The UCC Event Register (UCCE) already has unambigous macro definitions in qe.h,
> so we should not be defining our own in the UCC Ethernet driver.
> 
> Removed unused local variable 'dev' from ucc_geth_poll(), which fixes a warning
> caused by commit 908a7a16b852ffd618a9127be8d62432182d81b4.
> 
> Replaced in_be/out_be pairs with setbits32 or clrbits32, where applicable.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied.
