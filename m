Date: Fri, 26 Mar 2004 09:16:47 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: O(1) scheduler for PPC?
In-Reply-To: <Pine.LNX.4.44.0403260858030.25458-100000@linpc003.aimsys.nl>
Message-ID: <Pine.LNX.4.44.0403260914350.7016-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 26 Mar 2004, Jaap-Jan Boor wrote:

>
> On Thu, 25 Mar 2004, Steven Scholz wrote:
>
> >
> > Hi there,
> >
> > is the backport of Ingo Molnar's O(1) scheduler in the official linux-2.4.2x
> > tree and is it available for the PPC?
>
> an up-to-date patch together with the preemptible kernel and low-latency
> patches for 2.4.25 are available here:
>
> http://www.plumlocosoft.com/kernel
>

note that, after applying the 'base' patch you need to add the
CONFIG_LOLAT option to arch/ppc/config.in and apply thew following
change in include/asm-ppc/bitopts.h

285c285
< static inline int _sched_find_first_bit(unsigned long *b)
---
> static inline int sched_find_first_bit(unsigned long *b)


Jaap-Jan

> >
> > Thanks,
> >
> > Steven
> >
> >
> >
>
> --
> J.G.J. Boor			  Anton Philipsweg 1
> Software Engineer		  1223 KZ Hilversum
> AimSys bv              		  tel. +31 35 689 1941
> Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl
>
>
>

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
