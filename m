Date: Thu, 18 May 2000 16:33:42 +0200
From: Sven LUTHER <luther@debian.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: luther@dpt-info.u-strasbg.fr,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Pismo status
Message-ID: <20000518163342.A14744@lambda.u-strasbg.fr>
Reply-To: luther@dpt-info.u-strasbg.fr
References: <39226066.BF822A70@mpifr-bonn.mpg.de> <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de <20000517140836.A12638@lambda.u-strasbg.fr> <v04220800b5492487abdb@[10.0.0.42]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04220800b5492487abdb@[10.0.0.42]>; from tas@mindspring.com on Wed, May 17, 2000 at 10:15:24PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 17, 2000 at 10:15:24PM -0700, Timothy A. Seufert wrote:
> At 2:08 PM +0200 5/17/00, Sven LUTHER wrote:
> >On Wed, May 17, 2000 at 12:54:22PM +0200, Michael Schmitz wrote:
> >>  > Tim Wojtulewicz wrote:
> >>  > > No it's definitely supposed to have a fan.  It comes on in MacOS.
> >>  > > The problem is that the PMU is not fully supported yet, so it doesn't
> >>  > > understand that the processor is too hot.  I'm trying to find
> >>  >                       ^^^^^^^^^^^^^^^^^^^^
> >>  > Does this mean that I can damage the machine if I just run a high-load
> >>  > program?!?
> >>
> >>  I strongly doubt that. The PMU should handle this autonomously, regardless
> >>  of Linux support for the PMU.
> >
> >Also, i think the ppc cpu will halt itself when becoming too hot,
>
> No, it will not.
>
> The PowerPC 750 (G3) and 7400 (G4) can both fire off an interrupt
> when the on-die temperature sensor reading rises above a trigger
> value (or falls below a second trigger value).  This feature *could*
> be used by an operating system to slow down the CPU (through the

So this mean that the G3 and G4 cpus have both the equivalent of
speedstep/whatever that AMD & Intel are introducing as a big novelty ?

> instruction cache throttling feature) or halt it to prevent
> overheating.  However, there is no hardware feature which can halt
> the CPU without software control.

Are you sure about this ? did you already manage to burn out a ppc cpu like
you do when running a pentium without a fan ?

> >  and not let
> >itself burn. At elast it was so since the earlier 680x0 cpus.
>
> As far as I know none of the 680x0 CPUs even had an on-die
> temperature sensor, let alone a thermal shutdown feature.

I think to remember that the later 680X0 have, maybe not a temperature sensor,
but a way to halt themself before burning, ...

Friendly,

Sven LUTHER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
