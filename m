Date: Mon, 24 Feb 2003 08:51:40 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Oops when inserting PCMCIA flash card (IDE)
Message-ID: <20030224165140.GA11267@reepicheep.ics.uci.edu>
References: <E18nL1U-0007Ag-00@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E18nL1U-0007Ag-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 24, 2003 at 05:00:03PM +0100, Michel Lanners wrote:
> For a number of kernel versions (at least 4 months) I get a kernel oops
> when inserting a CF card in my TiBook's PCMCIA slot.

FWIW, mine's been broken off and on throughout the 2.4.x series.
Sometimes the driver has refused to load, do to resource prbolems.
Sometimes the machine will crash, probably, because interrupts are not
being handled correctly during DE device probe.  I don't think I've
ever had a kernel that slept properly with a CF card.  I'm currently
using 2.4.20-pre9-ben0 from October 14 (kernel compiled 00:03:50 Oct 15),
which seems to work as long as I don't put my TiPB to sleep with the
CF card in.

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student Researcher
University of California, Irvine
"sed fortius fide et gaude in Christo" -Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
