Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F1E01DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 12:03:49 +1000 (EST)
Date: Sun, 17 Aug 2008 19:03:48 -0700 (PDT)
Message-Id: <20080817.190348.73384265.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: bug in lmb_enforce_memory_limit()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1219024832.8115.4.camel@localhost>
References: <1218847582.7576.6.camel@localhost>
	<20080815.195724.238982506.davem@davemloft.net>
	<1219024832.8115.4.camel@localhost>
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
Date: Mon, 18 Aug 2008 12:00:32 +1000

> Although I can't find a system with holes (the newer hypervisors make
> things look contiguous I think), so I can't really test the interesting
> case.

I have several so I'll make sure it works in such cases :)
