Date: Mon, 17 Jun 2002 09:28:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020617162800.GU13541@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <20020617153255.GS13541@opus.bloom.county> <3D0E0253.A6A56B53@imc-berlin.de> <20020617154925.GT13541@opus.bloom.county> <3D0E07DA.327DF963@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0E07DA.327DF963@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 17, 2002 at 06:01:30PM +0200, Steven Scholz wrote:
> Tom Rini wrote:
>
> > > Ehm... Does that mean you won't accept patches vs linuxppc-2.4 though
> > > !?!?
> >
> > That means I want this to be done in 2.5 first.  Where development is
> > supposed to happen.  I have this feeling that fixing commproc.h will be
> > more than 1 simple patch and we should do it in the development tree
> > first.  Then, once that's all done and people are happy with it, we can
> > move it to linuxppc_2_4.
>
> Hmm... Just moving the DEFINEs from commproc.h to the board specific
> header files is indeed just ONE simple patch. I've done that already. I
> am not sure what else you mean by "fixing commproc.h"!?

Well, commproc.h is a rather large dumping ground.

What bits does PPCBoot need to get at really?  What bits are needed for
i2c?  What can we legitimately move into another header (and add
__KERNEL__ too).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
