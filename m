Date: Wed, 22 Aug 2001 17:12:29 -0400 (EDT)
Message-Id: <200108222112.f7MLCTt439203@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Cc: paulus@samba.org, paulus@samba.org
Subject: Re: assorted kernel patches
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras writes:
> Edward Swarthout writes:

>> 1. Support for hardware breakpoints for process threads.
>
> A good idea in general although I will be interested to see
> how this interacts with xmon's and kgdb's use of iabr/dabr.

Who cares? Take a look at the Alpha and i386 Linux ports.
Debugger support for users is important. Kernel hackers can
live without it. (including myself) Go check the linux-kernel
archives to see Linus Torvalds and David S. Miller's opinions
about kernel debuggers.

It would be nice if the ppc port met the Linus standard.

>> 2. Allow superviser (MSR[PR]=0) user threads.
>
> Hmmm, you'll need to explain exactly why this is a good idea
> and why it won't break anything. Without a good strong argument
> I would be inclined to reject this. I don't see what you can do
> with a "user" thread running in supervisor mode that you can't
> do with a kernel module.

It is good for experimenting with processor features.

On an embedded system, it is often nice to turn off interrupts
to do a bit of super-hard real-time from userspace. The user code
may well be incompatible with the kernel. (non-GPL C++ or FORTRAN)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
