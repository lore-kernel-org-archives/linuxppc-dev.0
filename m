Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A0F4FDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 19:04:13 +1100 (EST)
Date: Fri, 20 Feb 2009 00:03:54 -0800 (PST)
Message-Id: <20090220.000354.198880712.davem@davemloft.net>
To: anton@samba.org
Subject: Re: [PATCH] Enable hashdist by default on PowerPC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090220051956.GE32195@kryten>
References: <20090218051112.GA32195@kryten>
	<20090218.011924.07030610.davem@davemloft.net>
	<20090220051956.GE32195@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>
Date: Fri, 20 Feb 2009 16:19:56 +1100

> 
> Hi David,
> 
> > I should probably do this on sparc64 too.
> > 
> > Why don't we just change this thing to CONFIG_64BIT?
> 
> I agree. How does this look?

Hmmm... my bad, I think you need to keep the CONFIG_NUMA
there too as there is a TLB usage penalty for non-NUMA
systems if you only use CONFIG_64BIT there.
