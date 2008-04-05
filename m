Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DF40DDDF7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 16:41:54 +1100 (EST)
Date: Fri, 4 Apr 2008 22:41:46 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20080405054146.GA10233@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
	<1207351869.6675.0.camel@johannes.berg>
	<1207372496.10388.441.camel@pasglop>
MIME-Version: 1.0
In-Reply-To: <1207372496.10388.441.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 05, 2008 at 04:14:56PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Sat, 2008-04-05 at 01:31 +0200, Johannes Berg wrote:
> > > This version takes care to save and restore *all* the volatile registers
> > > around the call to trace_hardirqs_off in transfer_to_handler, and should
> > > fix the anomalies seen by Johannes Berg.  I've tested on 7447- and 8548-
> > > based boards.
> > 
> > Still has problems on my machine. Maybe to do with non-maskable PMU
> > interrupts? (saw a patch about something like that float by, don't
> > really have any idea whether it's related to this work or not)
> 
> Or more likely he missed some clobber somewhere, it took me a while to
> get that right on ppc64 (well... hopefully it -is- right by now :-)

Yep, likely.  I'd appreciate help finding it.  I'm at a loss.  :-)

-Dale
