Date: Mon, 16 Dec 2002 08:31:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marius Groeger <mag@sysgo.de>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Arctic-2 MTD driver
Message-ID: <20021216153128.GL6095@opus.bloom.county>
References: <20021216150123.GH6095@opus.bloom.county> <Pine.LNX.4.40.0212161624180.10282-100000@mag.devdep.sysgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.40.0212161624180.10282-100000@mag.devdep.sysgo.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 04:28:06PM +0100, Marius Groeger wrote:
> On Mon, 16 Dec 2002, Tom Rini wrote:
>
> > On Mon, Dec 16, 2002 at 09:46:50AM +0100, Marius Groeger wrote:
> > >
> > > Hello David,
> > >
> > > On Mon, 16 Dec 2002, David Gibson wrote:
> > >
> > > > Having committed the core support code for the Arctic-2, here come
> > > > some drivers for it.  Below is an MTD map for the Arctic-2, derived
> > > > from beech-mtd.c.  Essentially all it does is provide suitable
> > > > hardwired partitions.
> > >
> > > Can you also post this to the linux-mtd folks?
> >
> > No point in doing that yet, as the underlying support code for the
> > Arctic-2 won't be making Marcelo's tree for a while yet.
>
> I don't see a point in NOT doing this. It will have to be done anyway,
> so David might as well do it now and be done with it.

Unusable, untestable code which may or may not need minor changes before
going upstream? (For example, I need to go and do similar changes to an
upstream version of maps/Config.in like I just did to the _devel ones).

There's no real advantage to doing it now or later, in other words. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
