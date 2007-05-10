Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 732EADDEF6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:49:45 +1000 (EST)
Date: Thu, 10 May 2007 01:49:44 -0700 (PDT)
Message-Id: <20070510.014944.41634852.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1178786505.14928.225.camel@localhost.localdomain>
References: <1178778951.14928.215.camel@localhost.localdomain>
	<20070510003528.395b122b.akpm@linux-foundation.org>
	<1178786505.14928.225.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 May 2007 18:41:45 +1000

> 
> > > What about my comment layout style ? I've been using that forever ... Or
> > > do you mean I should use a function documentation style layout there ?
> > 
> > /* This
> >  * is
> >  * wrong
> >  */
> > 
> > /*
> >  * This
> >  * is
> >  * right
> >  */
> 
> Hrm... how bad are you about that one ? I must say I prefer my style :-)

I think the "wrong" one is right because screen real-estate matters.
In fact that's the one I use and enforce throughout the networking
and sparc ports.

I even hand edit out those empty comment lines in patches submitted
to me when I spot them.
