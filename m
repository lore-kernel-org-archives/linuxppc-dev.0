Date: Tue, 20 Jun 2000 15:25:09 +0200
From: De Schrijver Peter <schrijvp@rc.bel.alcatel.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Message-ID: <20000620152509.O1177@rc.bel.alcatel.be>
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be> <20000620122329.13473@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000620122329.13473@mailhost.mipsys.com>; from bh40@calva.net on Tue, Jun 20, 2000 at 02:23:29PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> We still can decide (and that's what I currently do in the kernel) that
> IO space is only supported on one of those 3 busses (the one on which the
> external PCI is). This prevents however use of IOs on the AGP slot, which
> is a problem for things like XFree who may try to use VGA addresses on
> the card.
>

Is this really a problem ? I would expect AGP cards to be fully addresseable via
the I/O space assigned in the PCI IO resource base ?

Peter.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
