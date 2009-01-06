Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 646A8DE5B9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 05:47:23 +1100 (EST)
Date: Tue, 06 Jan 2009 10:47:24 -0800 (PST)
Message-Id: <20090106.104724.60763449.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] net/ehea: use consistant type
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090106163454.b9f93b08.sfr@canb.auug.org.au>
References: <20090106110511.43b0a87a.sfr@canb.auug.org.au>
	<20090105.161926.141190504.davem@davemloft.net>
	<20090106163454.b9f93b08.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	netdev@vger.kernel.org, themann@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Jan 2009 16:34:54 +1100

> ehea_plpar_hcall9() takes an "unsigned long" array to return its results,
> so change the arrays we pass to it to match.  This is currently only
> 64 bit code, so the transformation is actually a noop, but because
> ehea_plpar_hcall9() copies the values of registers into the array,
> if this was ported to a 32 bit hypervisor interface "unsigned long"
> would probably still be the correct type.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied.
