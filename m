Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0D72DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 22:58:12 +1000 (EST)
Date: Wed, 1 Aug 2007 14:57:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h
	interface for platforms]
Message-ID: <20070801125753.GB27199@lst.de>
References: <20070711093113.GE4375@moe.telargo.com>
	<200707110856.58463.david-b@pacbell.net>
	<20070711161633.GA4846@lst.de>
	<200707111002.55119.david-b@pacbell.net>
	<20070711203454.GC2301@flint.arm.linux.org.uk>
	<20070713091203.GE11476@nd47.coderock.org>
	<20070801072807.GL4529@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070801072807.GL4529@moe.telargo.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > It doesn't make any assumption on struct clk, it's just a
> > wrapper around functions from clk.h.
> > Point of this patch was to abstract exported functions, since
> > arch/powerpc/ can support multiple platfroms in one binary.
> 
> So... the thread just ended without any consensus, ACK or whatever.
> 
> Choices I see:
> - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
>   every implemenation fill some global struct.
> - leave this patch as it is, abstraction only for arch/powerpc/.
> - or I can just forget about this, and leave it for the next sucker
>   who will want nicer clock handling in some driver

It seems like arm really wants this optimized to the last cycle
and no abstraction inbetween so we're probably stuck with the status
quo.   I'm pretty sure this will get too messy sooner and later and
people will clean the mess up, but due to the political issues I
don't think it's fair to put that burden on you just for submitting
the powerpc implementation.

So, please leave the patch as-is.
