Date: Mon, 16 Dec 2002 16:28:06 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Arctic-2 MTD driver
In-Reply-To: <20021216150123.GH6095@opus.bloom.county>
Message-ID: <Pine.LNX.4.40.0212161624180.10282-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 16 Dec 2002, Tom Rini wrote:

> On Mon, Dec 16, 2002 at 09:46:50AM +0100, Marius Groeger wrote:
> >
> > Hello David,
> >
> > On Mon, 16 Dec 2002, David Gibson wrote:
> >
> > > Having committed the core support code for the Arctic-2, here come
> > > some drivers for it.  Below is an MTD map for the Arctic-2, derived
> > > from beech-mtd.c.  Essentially all it does is provide suitable
> > > hardwired partitions.
> >
> > Can you also post this to the linux-mtd folks?
>
> No point in doing that yet, as the underlying support code for the
> Arctic-2 won't be making Marcelo's tree for a while yet.

I don't see a point in NOT doing this. It will have to be done anyway,
so David might as well do it now and be done with it.

Regards
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
