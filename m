Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8E8EADDF7A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 09:33:28 +1100 (EST)
Date: Wed, 13 Feb 2008 14:33:59 -0800 (PST)
Message-Id: <20080213.143359.258873954.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero base
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
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
Date: Wed, 13 Feb 2008 07:37:27 -0600 (CST)

> If we add to an empty lmb region with a non-zero base we will not coalesce
> the number of regions done to one.  This causes problems on ppc32 for the
> memory region as its assumed to only have one region.
> 
> We can fix this be easily specially casing the initial add to just replace
> the dummy region.
> 
> ---
> 
> Posting this since Dave's looking a pulling the lmb code out into lib/ and
> sharing it between powerpc and sparc.
> 
> (this is my git tree git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git)

I noticed this issue when I use lmb on sparc64 and I intended to bring
it up eventually.  Thanks for fixing it!
