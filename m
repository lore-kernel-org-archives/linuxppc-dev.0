Message-ID: <3B4A14B1.FF9047D4@mvista.com>
Date: Mon, 09 Jul 2001 13:31:45 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: "Wright, David" <dwright@infiniswitch.com>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdb with 405 target
References: <FF6CF34C346E724596A2FB5CAAB2C49750C325@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

My apologies for not getting back to you.  Thank you for sending me
your report!

David found the last couple details to get ptrace working.


Matthias,

Try moving up to the 01.04.12 sources and see if that solves
the problem for you.

(The changes are also moving, a bit at a time, into the main
PowerPC tree, but the ptrace changes aren't there yet.)

-Frank


"Wright, David" wrote:
>
> We got a patch for this problem from MontaVista; once I fixed a
> couple of bugs in the patch, it worked fine.  I supplied a report
> to MontaVista about the bugs, but never got any mail back from
> them, so I don't know what happened after that.
>
>   -- David Wright
>
> > -----Original Message-----
> > From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
> > Sent: Monday, July 09, 2001 11:01 AM
> > To: linuxppc-embedded
> > Subject: gdb with 405 target
> >
> >
> >
> > Hi,
> >
> > I got the following problem when I try to debug a sample
> > program on one
> > of our IBM405 targets.
> > I read some earlier postings in this list that describe similar
> > problems.
> >
> > So my question: Is this problem already fixed ? Where can I
> > find a fix ?
> >
> > The kernel is build from the MontaVista 405 sources from beginning of
> > march.
> >
> > sh-2.03# gdb /bin/demo
> > GNU gdb 5.0
> > Copyright 2000 Free Software Foundation, Inc.
> > GDB is free software, covered by the GNU General Public
> > License, and you
> > are
> > welcome to change it and/or distribute copies of it under certain
> > conditions.
> > Type "show copying" to see the conditions.
> > There is absolutely no warranty for GDB.  Type "show warranty" for
> > details.
> > This GDB was configured as "powerpc-hardhat-linux"...
> > (gdb) run
> > Starting program: /bin/demo
> >
> > Program terminated with signal SIGTRAP, Trace/breakpoint trap.
> > The program no longer exists.
> > (gdb)
> >
> > Oops: Exception in kernel mode, sig: 5
> > NIP: C0002D70 XER: 00000000 LR: C00028BC SP: C0997E80 REGS: c0997dd0
> > TRAP: 2000
> > MSR: 00009230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c0996000[33] 'demo' Last syscall: 6
> > last math 00000000 last altivec 00000000
> > GPR00: 00000001 C0997E80 C0996000 C0997E90 30002BC0 30000828 30000828
> > 00000000
> > GPR08: 300275C8 00000000 00000003 30026FF8 30026DC8 100A11E4 1009FDB0
> > 00000000
> > GPR16: 00000000 00000000 00000000 1004CA70 00009230 00997E80 00000000
> > C00028BC
> > GPR24: C0002D70 10000034 00000000 30026B54 00000000 30026B88 300262C0
> > 7FFFFA50
> > Call backtrace:
> > C00028BC 30004704 3000DEE0 30003204 30003144 30010C8C
> >
> >
> > Thanks for advice
> > Matthias
> > --
> > -------------------------------------------------
> > \ Matthias Fuchs                                 \
> >  \ esd electronic system design Gmbh              \
> >   \ Vahrenwalder Straße 205                        \
> >    \ D-30165 Hannover                               \
> >     \ email: matthias.fuchs@esd-electronics.com      \
> >      \ phone: +49-511-37298-0                         \
> >       \ fax:   +49-511-37298-68                        \
> >        --------------------------------------------------
> >
> >
> >
>

--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
