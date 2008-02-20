Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 84D1CDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:29:28 +1100 (EST)
Date: Tue, 19 Feb 2008 16:30:03 -0800 (PST)
Message-Id: <20080219.163003.152862383.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Feb 2008 13:51:37 -0600 (CST)

> If we add to an empty lmb region with a non-zero base we will not coalesce
> the number of regions down to one.  This causes problems on ppc32 for the
> memory region as its assumed to only have one region.
> 
> We can fix this easily by causing the initial add to replace the dummy
> region.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Fix a bug the initial patch introduced if we have a region that gets added
> at the beginning of the list we wouldn't actually add it.
> 
> Dave can you replace the patch in you tree with this one.

I think my tree has already or will soon be pulled in so
I don't want to rebase it.

Why don't you simply send me the relative bug fix instead?

Thanks!
