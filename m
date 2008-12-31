Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6F555DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 16:50:59 +1100 (EST)
Date: Tue, 30 Dec 2008 21:51:01 -0800 (PST)
Message-Id: <20081230.215101.228854586.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] net/ehea: use consistent type
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081231141730.81449124.sfr@canb.auug.org.au>
References: <20081231141730.81449124.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, netdev@vger.kernel.org, raisch@de.ibm.com,
	themann@de.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 Dec 2008 14:17:30 +1100

> ehea_plpar_hcall9() takes an unsigned long array, so pass that.
> 
> This change will avoid some warnings when we change u64 to unsigned
> long long.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Patch rejected, for the same reasons as the other driver
change.

We're not going to poop up some drivers with the assumption that long
is 64-bit.

Thanks ;-)
