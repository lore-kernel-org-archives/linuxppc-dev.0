Date: Sat, 6 Jan 2001 13:11:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: diekema_jon <diekema@bucks.si.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Root keys on bk://bitkeeper.fsmlabs.com:5000 have changed
Message-ID: <20010106131155.E556@opus.bloom.county>
References: <20010106104711.D1400@opus.bloom.county> <200101061940.f06Jdx904796@denx.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200101061940.f06Jdx904796@denx.local.net>; from wd@denx.de on Sat, Jan 06, 2001 at 08:39:59PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jan 06, 2001 at 08:39:59PM +0100, Wolfgang Denk wrote:
> In message <20010106104711.D1400@opus.bloom.county> you wrote:
> >
> > > It appears that the BitKeeper repository at bk://bitkeeper.fsmlabs.com:5000
> > > has changed.  What happened to the previous BK tree?  Was it replaced with the
> > > 2.4.0 baseline?
> >
> > The former 2_3 tree has been replaced with a new 2_4 tree which currently does
> > _not_ have all of the fixes needed for PPC.
>
> Is there some place where such decisions are discussed or at least announced?

Formally? Nope.  You just got the announcement. :)

> Things like that hit my with surprise again and again (and  obviously
> not only me).

Hey, it supprised me this morning to find out it had changed.  But it was also
expected.  2.3 is dead, it's now 2.4.

> A few days ago Steven Hanley <sjh@wibble.net> asked for the currently
> active devel tree. The question has not been answered yet.

Active devel for what?  The 2_5 tree (I'm sure if you search the -dev archives
there's a few pointers to it, bk://bk.fsmlabs.com:5005 is where the unstable
stuff happens, before moving to a stable tree.

> I really would appreciate a summary about the current  state  of  the
> different source trees.

Sure:
linuxppc_2_3 - "Dead", it still exists on the server, but it's going away.
linuxppc_2_4 - Where 2_3 used to be.  It doesn't compile at the moment, but it
will later today / tomorrow (I'm testing it right now).
linuxppc_2_5 - Same old unstable dev tree, still port 5005

> Any comment from the Powers That Be?

I don't know if I count, I just commit stuff :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
