Message-ID: <3CF7BF85.9AF1FB19@mvista.com>
Date: Fri, 31 May 2002 14:23:01 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jim Thompson <jim@musenki.com>,
	Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com> <20020531145120.GI32412@opus.bloom.county> <15607.36947.107412.219533@gargle.gargle.HOWL> <20020531151130.GN32412@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Fri, May 31, 2002 at 10:01:39AM -0500, Jim Thompson wrote:
> >
> > Tom Rini writes:
> > >
> > > On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:
> > >
> > > > Hello All,
> > > > I try to connect all my 64 Meg memoty on
> > > > Sandpoint-X3B,
> > > > but received a crash( with 32M all OK).
> > > > Source:
> > > > SP-X3B + Altimus MPC7410
> > > > HHL 2.0
> > > > Any ideas??
> > >
> > > DINK32 12.2 does not correctly initalize the memory controller on-board.
> > > DINK32 12.3 claims to do this correctly, but in some testing locally it
> > > still did not get everything correct.
> >
> > Could you be more specific as to what is missing?
>
> On the DINK32 12.2 side it blindly sets some parts up for 64mb total
> regardless of the ammount of memory.  I think there's other things as
> well, but Mark Greer would know better..

I only have 12.2 here and it initializes the wrong amount which will cause a
panic if you rely on the getting the amount of memory from how the memory ctlr
regs are set up.

The last time I really looked at what DINK was doing to the mem ctlr was back on
12.0 so my info is stale now.  Sounds like Tom has the most current, detailed
info on what DINK does.  Chances are, Sergiy, is that you'll  have to roll up
your sleeves and dig into it.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
