Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C0C55DDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 12:57:26 +1000 (EST)
Date: Fri, 15 Aug 2008 19:57:24 -0700 (PDT)
Message-Id: <20080815.195724.238982506.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: bug in lmb_enforce_memory_limit()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1218847582.7576.6.camel@localhost>
References: <1218713213.10673.17.camel@localhost>
	<20080815.152501.193746275.davem@davemloft.net>
	<1218847582.7576.6.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Sat, 16 Aug 2008 10:46:22 +1000

> On Fri, 2008-08-15 at 15:25 -0700, David Miller wrote:
> > Sounds great.  Mind if I push the following to Linus?
> 
> Looks good to me.
> 
> I'll test it on Monday. I don't know if I have a system with memory
> holes to test on, but I take it you do?
> 
> I notice some of our 32-bit code is using lmb_enforce_memory_limit() to
> enforce an address limit, which is technically broken, but is probably
> fine because it doesn't need to worry about holes.

Sounds like fun :-)

> Acked-by: Michael Ellerman <michael@ellerman.id.au>

Thanks for reviewing Michael.
