Date: Fri, 19 Oct 2001 15:58:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel clutter
Message-ID: <20011019155847.E10163@cpe-24-221-152-185.az.sprintbbd.net>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com> <3BD06614.800C99E8@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD06614.800C99E8@raleigh.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 19, 2001 at 01:42:44PM -0400, Ralph Blach wrote:

> This allows IBM to quickly integrate different sets of peripherals to a
> processor core.
> One only has to look to the 405 to see the effects of this.  Announced
> for the 405 are the
> 405CR, 405GP, NPE405H, NPE405L, the Ranier network processor, the 405LP
> and the stb04xxx. There are also many CSSPs which
> have 405 processor cores that have been designed or are in process.
> These CSSP's  have peripherals that are not in any of the
> of the released chips but are in IBM core library.  Many of these
> CSSP's  have customer designed peripherals.
> (This is NOT a sales pitch.  This is just to let everybody know that way
> IBM (and probably Mot ) stitches processors
> and peripherals together has changed. IE, It a LOT easier now to stich
> together Processor cores and components
> to make a CSSP. )

So it's a 405 core + other board (I use the term loosely here) bits
attached on a bus, right?  I think more work might still need to be
done for seperating stuff that's specific to a certain 405 board from
the more generic 'board bits', but I don't think it'll be too hard,
or too dramatic.

> All of these chips have a different mix of on chip peripherals.  Given
> the ease that the hardware designers
> now have in creating chips, we need a PPC linux structure that
> recognizes this.

So it's sort-of like throwing more PCI cards in a pmac?  They're always
on some sort of standard interface(s), yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
