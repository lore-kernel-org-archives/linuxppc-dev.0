Return-Path: <david-b@pacbell.net>
Received: from smtp104.sbc.mail.re2.yahoo.com (smtp104.sbc.mail.re2.yahoo.com
	[68.142.229.101]) by ozlabs.org (Postfix) with SMTP id 5117BDDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 09:32:16 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h
	interface for platforms]
Date: Thu, 2 Aug 2007 16:32:13 -0700
References: <20070711093113.GE4375@moe.telargo.com>
	<20070801072807.GL4529@moe.telargo.com>
	<20070801125753.GB27199@lst.de>
In-Reply-To: <20070801125753.GB27199@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708021632.13982.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 01 August 2007, Christoph Hellwig wrote:
> On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > > It doesn't make any assumption on struct clk, it's just a
> > > wrapper around functions from clk.h.
> > > Point of this patch was to abstract exported functions, since
> > > arch/powerpc/ can support multiple platfroms in one binary.
> > 
> > So... the thread just ended without any consensus, ACK or whatever.
> > 
> > Choices I see:
> > - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
> >   every implemenation fill some global struct.
> > - leave this patch as it is, abstraction only for arch/powerpc/.

That seems the best solution for now, I agree.


> > - or I can just forget about this, and leave it for the next sucker
> >   who will want nicer clock handling in some driver
> 
> It seems like arm really wants this optimized to the last cycle
> and no abstraction inbetween so we're probably stuck with the status
> quo.   I'm pretty sure this will get too messy sooner and later and
> people will clean the mess up, but due to the political issues I
> don't think it's fair to put that burden on you just for submitting
> the powerpc implementation.
> 
> So, please leave the patch as-is.
> 
