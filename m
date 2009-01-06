Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 53824DE5D0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 05:47:52 +1100 (EST)
Date: Tue, 06 Jan 2009 10:47:53 -0800 (PST)
Message-Id: <20090106.104753.91462944.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] ibmveth: use consistent types
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090106163908.2e6134f4.sfr@canb.auug.org.au>
References: <20081231140225.48b695ef.sfr@canb.auug.org.au>
	<20090106163908.2e6134f4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Jan 2009 16:39:08 +1100

> These variables are only used with an interface that just dumps their
> values into registers to be passed to the hypervisor. The arguments
> to that interface are declared to be "unsigned long", so make these
> variables match.  The macros are only used with these variables, so make
> them match as well.
> 
> This code is currently only built for 64bit powerpc, so the transformation
> is really a noop.  If the interface was ever ported to 32 bit, it would
> almost certainly still use registers to pass the parameters and so
> "unsigned long" would still be appropriate.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Also applied, thanks Stephen.
