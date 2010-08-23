Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 12611B70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 14:39:30 +1000 (EST)
Date: Sun, 22 Aug 2010 21:39:45 -0700 (PDT)
Message-Id: <20100822.213945.241455303.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] rwsem: Move powerpc atomic-long based
	implementation to asm-generic
From: David Miller <davem@davemloft.net>
In-Reply-To: <1282281295.22370.401.camel@pasglop>
References: <1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<1282281295.22370.401.camel@pasglop>
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
Date: Fri, 20 Aug 2010 15:14:55 +1000

> Other architectures who support cmpxchg and atomic_long can
> use that directly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: David S. Miller <davem@davemloft.net>

I'll move sparc64 over to this once it hits Linus's tree.
