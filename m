Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CD827DDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:53:25 +1000 (EST)
Date: Thu, 10 May 2007 01:53:28 -0700 (PDT)
Message-Id: <20070510.015328.104645983.davem@davemloft.net>
To: akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070510015036.ebded3ac.akpm@linux-foundation.org>
References: <20070510003528.395b122b.akpm@linux-foundation.org>
	<1178786505.14928.225.camel@localhost.localdomain>
	<20070510015036.ebded3ac.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 10 May 2007 01:50:36 -0700

> We discussed this a couple of months back.  davem landed firmly in the
> second camp and everyone then shut up ;)

No I landed in the first :-)))

I think the empty lines are a waste and only serve to eat
up precious screen real-estate when reading code.

It is possible that I used to use the empty line thing in
the past, but I definitely don't do that any more.
