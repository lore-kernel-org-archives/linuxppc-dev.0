Message-ID: <3D0E0253.A6A56B53@imc-berlin.de>
Date: Mon, 17 Jun 2002 17:37:55 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <20020617153255.GS13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:
>
> On Mon, Jun 17, 2002 at 11:20:02AM +0200, Steven Scholz wrote:
>
> > Hi there,
> >
> > I think we should move the board specific defines such as
> >
> > /***  RPXCLASSIC  *****************************************************/
> [snip]
> > etc. out of ./include/asm-ppc/commproc.h into the board specific header
> > files like ./arch/ppc/platforms/xxx.h
>
> Yes, we should.  Patches vs linuxppc-2.5 (note, you won't be able to
> boot 8xx unless you perform some other updates) happily accepted.

Ehm... Does that mean you won't accept patches vs linuxppc-2.4 though
!?!?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
