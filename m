Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2EB99DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 19:29:58 +1000 (EST)
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070510.015328.104645983.davem@davemloft.net>
References: <20070510003528.395b122b.akpm@linux-foundation.org>
	<1178786505.14928.225.camel@localhost.localdomain>
	<20070510015036.ebded3ac.akpm@linux-foundation.org>
	<20070510.015328.104645983.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 May 2007 19:29:06 +1000
Message-Id: <1178789346.5575.2.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Thu, 2007-05-10 at 01:53 -0700, David Miller wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Thu, 10 May 2007 01:50:36 -0700
> 
> > We discussed this a couple of months back.  davem landed firmly in the
> > second camp and everyone then shut up ;)
> 
> No I landed in the first :-)))
> 
> I think the empty lines are a waste and only serve to eat
> up precious screen real-estate when reading code.
> 
> It is possible that I used to use the empty line thing in
> the past, but I definitely don't do that any more.

Yup, I used to do the other one too but nowadays, I much prefer not
wasting that additional line unless specific circumstances, like I
want a kind of "title" in front of a whole block of other definitions
with their own comments.

Something like:


/*
 * foo management stuff
 */


/* This puts the bar in the foo
 */
code code code code

/* This does something you don't want to know about
 */
code code code code


But does it realy matter that much ? :-)

Cheers,
Ben.
