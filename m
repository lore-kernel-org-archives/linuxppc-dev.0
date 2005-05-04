Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B21F679E9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 10:05:27 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
In-Reply-To: <20050503234811.GA10048@cse.unsw.EDU.AU>
References: <1115072133.6031.33.camel@gaston>
	<20050503222200.GA29940@cse.unsw.EDU.AU>
	<1115163690.7568.45.camel@gaston>
	<20050503234811.GA10048@cse.unsw.EDU.AU>
Content-Type: text/plain
Date: Wed, 04 May 2005 10:03:13 +1000
Message-Id: <1115164994.7628.73.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-05-04 at 09:48 +1000, Ian Wienand wrote:
> On Wed, May 04, 2005 at 09:41:30AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-05-04 at 08:22 +1000, Ian Wienand wrote:
> > > Is there a fix in the works for the Radeon timing thing that makes the
> > > screen go a little weird on wakeup?
> > 
> > I don't know this problem, what happens precisely and what model of
> > radeon chip do you have ?
> 
> We discussed it briefly previously
> 
> http://lists.debian.org/debian-powerpc/2005/04/msg00138.html
> 
>  "Ok. I suspect the wakeup effect might be caused by the delays in
>  radeonfb that I added to work around some chip errata... You can try
>  hacking them out from the errata function in radeonfb.h"

Ah yes, those... oh well, that is not very urgent, and it should be a
bit better with my cmap batching patch. You can always hack locally and
remove the delay of 5ms in the PLL workaround in radeonfb.h since it
seems nobody ever really hits the bug taht this workaround is supposed
to fix...

Ben.
