Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id 7AC9ADDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:15:21 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Date: Wed, 11 Jul 2007 08:56:58 -0700
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
	<20070711103640.GB15536@lst.de>
In-Reply-To: <20070711103640.GB15536@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707110856.58463.david-b@pacbell.net>
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

On Wednesday 11 July 2007, Christoph Hellwig wrote:
> On Wed, Jul 11, 2007 at 11:32:20AM +0200, Domen Puncer wrote:
> > clk interface for arch/powerpc, platforms should fill
> > clk_functions.
> 
> Umm, this is about the fifth almost identical implementation of
> the clk_ functions.  Please, please put it into common code.
> 
> And talk to the mips folks which just got a similar comment from me.

You mean like a lib/clock.c core, rather than an opsvector?

ISTR that allowing custom platform-specific implementations
was intended to be a feature.  But it's also true that some
folks see lack of shared implementation code as a drawback;
so I've CC'd Russell King (who originated the interface for
ARM platforms).

- Dave
