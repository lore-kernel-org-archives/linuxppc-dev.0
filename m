Date: Wed, 2 Oct 2002 15:34:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021002053422.GL1848@zax>
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 01, 2002 at 09:26:18PM -0700, Allen Curtis wrote:
>
> > That's right.  Is there a reason for boards to have different
> > mappings?  I can well believe that there is, but the current tree
> > doesn't show it - all the boards (in the tree) that have PCI appear to
> > do the same initialisation of the windows.  It doesn't seem worthwhile
> > to create board specific PCI initialisation hooks until we have a
> > board that needs it.
>
> If all boards are suppose to have the same mapping, why doesn't someone
> document it as such? It would have saved me a lot of time. If it isn't a
> good enough rule to be documented then make the system flexible enough to
> take a different path if required. (proactive)

Um, well... I can't immediately think of a logical place to document
this.  It seems logical to me that the PCI setup should be handled by
the driver for the PCI bridge - which is common between the boards.
This could be seen as a first step of changing PCI from a special
system handled platform wide, to making the PCI bridge just another
gadget in the device tree.

There's no particular reason the mapping has to be the same between
boards, but I can't think of any particular reason you'd want it to be
different (maybe I just haven't seen a wacky enough board).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
