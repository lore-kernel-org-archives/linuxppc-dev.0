Date: Wed, 20 Nov 2002 12:14:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel, rc1 and rc2 problem.
Message-ID: <20021120191423.GA13132@opus.bloom.county>
References: <20021120160108.GJ779@opus.bloom.county> <IGEFJKJNHJDCBKALBJLLEECOFIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEECOFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 20, 2002 at 07:55:35PM +0100, Joakim Tjernlund wrote:
>
> > >
> > > hmm, my i2c stuff got into rc2 (and uart too?). I see this on rc2 AND rc1, but NOT in pre8.
> > > No, I have not tried to port it to vanilla 2.4.x. It requires some work to do that.
> >
> > They both made it in post rc1 I think, yes.  Try going back carefully
> > via bk changes and bk export -tr1.xxxxx (find when
> > /home/.../linuxppc_2_4 was merged into /home/.../linuxppc_2_4_devel).
>
> The error ocurres between changeset 1.1130 - 1.1137.
> I forgot to mention that the error only happens on a 862,100Mhz, 16KB icache, 8KB dcache.
> My 860,80Mz does not show the problem.
>
> Idea's ?

Can you narrow down the ChangeSet it occured at a bit?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
