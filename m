Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0D52B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Aug 2010 20:24:43 +1000 (EST)
Subject: Re: 64-bit ppc rwsem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20100818.222925.233689776.davem@davemloft.net>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Aug 2010 20:24:19 +1000
Message-ID: <1282213459.22370.357.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2010-08-18 at 22:29 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 19 Aug 2010 15:23:23 +1000
> 
> > Similar here, but using atomic_long_t instead so it works for 32-bit too
> > for me. I suppose we could make that part common indeed.
> > 
> > What about asm-generic/rwsem-atomic.h  or rwsem-cmpxchg.h ?
> 
> Using rwsem-cmpxchg.h sounds best I guess.

Ok, I'll send a new patch tomorrow that does that.

Cheers,
Ben.
