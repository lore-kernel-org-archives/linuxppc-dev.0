Date: Thu, 12 Jun 2003 13:44:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akuster@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GPL inconsistency in arch/ppc/ocp/xlinx/
Message-ID: <20030612204444.GA19453@work.bitmover.com>
References: <20030524201213.GA8256@lst.de> <20030612203205.GA23017@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030612203205.GA23017@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 12, 2003 at 10:32:05PM +0200, Christoph Hellwig wrote:
>
> On Sat, May 24, 2003 at 10:12:13PM +0200, Christoph Hellwig wrote:
> > Hi Armin,
> >
> > you seem to have added the the directory in the topic to the LinuxPPC
> > trees.  Unfortunately they have a license consitency that basically
> > makes them illegal to distribute, they claim to be under GPL but have
> > the following notice:
> >
> > *     Xilinx products are not intended for use in life support appliances,
> > *     devices, or systems. Use in such applications are expressly prohibited.
> >
> > Could you please contact Xilinc to clarify the license and/or remove
> > those files from the tree?  Thanks.
>
> As there hasn't been any answer yet I think these files should be
> remove to ensure the linuxppc tree is legally distributable.

Note: I don't care one way or the other how or if this is resolved.  I'm
just making an observation.

You might want to be careful about advertising why you want these files
removed because the Xilinx clause is just covering their butt.  If someone
uses Linux in some life support system and someone dies, the fact that
the community removed these files because of that clause could be construed
as a statement that Linux was suitable for life support systems.  It gives
the lawyers ammo.

Personally, I wouldn't get that excited about that clause, I think that
enforcing the GPL to that extent on principle is likely to backfire.  But
that's my opinion and worth what you paid for it.

Neither I nor BitMover have any sort of relationship with Xilinx, this is
just my opinion.
--
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
