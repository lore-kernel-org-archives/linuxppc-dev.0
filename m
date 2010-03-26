Return-Path: <josh@joshtriplett.org>
Received: from slow3-v.mail.gandi.net (slow3-v.mail.gandi.net [217.70.178.89])
	by ozlabs.org (Postfix) with ESMTP id 11231B7BFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 10:02:50 +1100 (EST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
	[217.70.183.193])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id DDFEC382B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 23:59:32 +0100 (CET)
Date: Fri, 26 Mar 2010 15:59:16 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Wolfgang Wegner <wolfgang@leila.ping.de>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100326225916.GA5690@feather>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
	<20100326221707.GA1953@leila.ping.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100326221707.GA1953@leila.ping.de>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Greenberg <andrew@psas.pdx.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 11:17:07PM +0100, Wolfgang Wegner wrote:
> Hi Josh,
> 
> On Fri, Mar 26, 2010 at 02:32:02PM -0700, Josh Triplett wrote:
> > On Fri, Mar 26, 2010 at 12:22:32PM -0600, Grant Likely wrote:
> > > 
> > > Not all CF adapters have all the pins wired up that are needed for
> > > *DMA modes.  That is the most likely problem.
> > 
> > True, but we bought a card that specifically advertises support for
> > UDMA, and says UDMA right on the card's label.
> > 
> > http://store.lexar.com/?productid=CF8GB-300-381
> 
> Grant was referring to the adapter, not the card!
> 
> In fact I still have to see a single CF-to-IDE adapter that does
> have the wires needed for (U)DMA without me soldering them in place...

Oh!  OK, that makes more sense.

However, according to one of our hardware hackers, Andrew Greenberg
(CCed), the STK5200 development breakout board for the TQM5200 *does*
have the DMA pins wired up correctly, at least according to its
schematic.  That doesn't guarantee that the board matches the schematic,
of course.

Any other ideas for things we could check to try to track down this
problem?

- Josh Triplett
