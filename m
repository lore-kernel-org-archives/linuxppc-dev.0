Date: Wed, 20 Nov 2002 09:01:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel, rc1 and rc2 problem.
Message-ID: <20021120160108.GJ779@opus.bloom.county>
References: <20021120152302.GI779@opus.bloom.county> <IGEFJKJNHJDCBKALBJLLOECMFIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOECMFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 20, 2002 at 04:46:05PM +0100, Joakim Tjernlund wrote:
>
> >
> > On Wed, Nov 20, 2002 at 12:55:01PM +0100, Joakim Tjernlund wrote:
> > >
> >
> > > I upgraded my linuxppc_2_4_devel from pre8(1.1130) to rc1(1.1157) and noticed that
> > > may syslog had problems to start:
> > >
> > [snip]
> >
> > > I then tried rc2(BK curr) and got the same problem. I am running a custom mpc860 board.
> > >
> > > Anyone else noticed this?
> >
> > I haven't tried yet.  Have you tried 'porting' your custom board to
> > vanilla 2.4.x, which would make it easier to see which, if any of these
> > upsteram revisions introduced a problem?  The only 8xx-specific changes
> > in that time have been your i2c changes and a serial fixup.
>
> hmm, my i2c stuff got into rc2 (and uart too?). I see this on rc2 AND rc1, but NOT in pre8.
> No, I have not tried to port it to vanilla 2.4.x. It requires some work to do that.

They both made it in post rc1 I think, yes.  Try going back carefully
via bk changes and bk export -tr1.xxxxx (find when
/home/.../linuxppc_2_4 was merged into /home/.../linuxppc_2_4_devel).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
