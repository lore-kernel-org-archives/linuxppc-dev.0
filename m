Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26E07DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 19:09:15 +1000 (EST)
Date: Fri, 3 Aug 2007 09:36:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h
	interface for platforms]
Message-ID: <20070803083616.GA14516@flint.arm.linux.org.uk>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070801072807.GL4529@moe.telargo.com>
	<20070801125753.GB27199@lst.de>
	<200708021632.13982.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708021632.13982.david-b@pacbell.net>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	Christoph Hellwig <hch@lst.de>, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 04:32:13PM -0700, David Brownell wrote:
> On Wednesday 01 August 2007, Christoph Hellwig wrote:
> > On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > > > It doesn't make any assumption on struct clk, it's just a
> > > > wrapper around functions from clk.h.
> > > > Point of this patch was to abstract exported functions, since
> > > > arch/powerpc/ can support multiple platfroms in one binary.
> > > 
> > > So... the thread just ended without any consensus, ACK or whatever.
> > > 
> > > Choices I see:
> > > - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
> > >   every implemenation fill some global struct.
> > > - leave this patch as it is, abstraction only for arch/powerpc/.
> 
> That seems the best solution for now, I agree.

I've not been avoiding replying further to this thread in spite, it's
just that I've not had any time what so ever to look at this further.
It's very low priority for me at the moment, so it's getting zero time,
and will continue to be in that state for at least the next month and
a bit.  Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
