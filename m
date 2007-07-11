Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56F75DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:17:00 +1000 (EST)
Date: Wed, 11 Jul 2007 18:16:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711161633.GA4846@lst.de>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
	<20070711103640.GB15536@lst.de>
	<200707110856.58463.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707110856.58463.david-b@pacbell.net>
Cc: linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
	Domen Puncer <domen.puncer@telargo.com>, Christoph Hellwig <hch@lst.de>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > Umm, this is about the fifth almost identical implementation of
> > the clk_ functions.  Please, please put it into common code.
> > 
> > And talk to the mips folks which just got a similar comment from me.
> 
> You mean like a lib/clock.c core, rather than an opsvector?

I mean an ops vector and surrounding wrappers.  Every architecture
is reimplementing their own dispatch table which is rather annoying.

What would a lib/clock.c do?
