Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 03D9BDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:53:43 +1100 (EST)
Date: Wed, 13 Feb 2008 16:54:13 -0800 (PST)
Message-Id: <20080213.165413.201539871.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] Add include of linux/of.h to numa.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <3bcbba96837cfcdeb873d26d51241c9659e77930.1202949456.git.michael@ellerman.id.au>
References: <3bcbba96837cfcdeb873d26d51241c9659e77930.1202949456.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 14 Feb 2008 11:37:49 +1100 (EST)

> numa.c requires routines in linux/of.h, so should include it.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Thanks for looking into these build failures Michael.

I actually just finished respinning the LMB tree, which
I'll post about next, and I dealt with this asm/prom.h
issue in what I believe should be a more fail-safe way
from the get-go.

Have a look when I post that, and let me know if the build is OK.

Thanks!
