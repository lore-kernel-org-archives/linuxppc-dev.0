Date: Fri, 13 Dec 2002 10:13:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Move 405LP RTC support from beech.c into ibm405lp.c
Message-ID: <20021212231311.GI4631@zax.zax>
References: <20021212035459.GF4631@zax.zax> <1039709875.3537.20.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1039709875.3537.20.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 12, 2002 at 10:17:44AM -0600, Hollis Blanchard wrote:
> On Wed, 2002-12-11 at 21:54, David Gibson wrote:
> >
> > The RTC support (written by Todd Poynor) for the Beech is actually in
> > the 405LP chip itself, not just on the Beech board.
> <snip>
>
> As a separate patch (either before or after your move), I'd like to see
> the following patch committed. The current "reset" code doesn't follow
> the sequence described in the manual, and doesn't really reset the chip.
> Until I added this code, the RTC usually would simply not advance. I've
> tested this thoroughly on Beech (405LP 1.1).

Well, I've committed my patch (and I also moved the 405LP's
PPC4xx_ONB_IO_PADDR definition into ibm405lp.h).  Could you redo your
patch against the current tree?

> Also, the comment makes me curious - why rely on the BIOS to set the
> right input frequency? It's just one more line of code here (and a
> #define or two for the various boards).

Well, I'd be in favour of setting it here (under my philosphy of
"never trust the firmware not to be crap").

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
