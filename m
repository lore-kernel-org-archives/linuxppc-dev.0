Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D8B3CB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Aug 2010 15:29:07 +1000 (EST)
Date: Wed, 18 Aug 2010 22:29:25 -0700 (PDT)
Message-Id: <20100818.222925.233689776.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: 64-bit ppc rwsem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1282195403.22370.296.camel@pasglop>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 19 Aug 2010 15:23:23 +1000

> Similar here, but using atomic_long_t instead so it works for 32-bit too
> for me. I suppose we could make that part common indeed.
> 
> What about asm-generic/rwsem-atomic.h  or rwsem-cmpxchg.h ?

Using rwsem-cmpxchg.h sounds best I guess.
