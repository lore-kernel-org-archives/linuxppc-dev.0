From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15236.22289.93463.203180@cargo.ozlabs.ibm.com>
Date: Thu, 23 Aug 2001 11:06:25 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: assorted kernel patches
In-Reply-To: <200108222112.f7MLCTt439203@saturn.cs.uml.edu>
References: <200108222112.f7MLCTt439203@saturn.cs.uml.edu>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albert D. Cahalan writes:

> Who cares? Take a look at the Alpha and i386 Linux ports.
> Debugger support for users is important. Kernel hackers can
> live without it. (including myself) Go check the linux-kernel
> archives to see Linus Torvalds and David S. Miller's opinions
> about kernel debuggers.

I find a simple debugger like xmon useful as an aid to understanding.
Neither Linus nor DaveM have ever said to me that xmon should be
removed.

In any case this is all vapor since Ed Swarthout has not posted his
patches for us to look at, nor has he sent them to me.

> >> 2. Allow superviser (MSR[PR]=0) user threads.
> >
> > Hmmm, you'll need to explain exactly why this is a good idea
> > and why it won't break anything. Without a good strong argument
> > I would be inclined to reject this. I don't see what you can do
> > with a "user" thread running in supervisor mode that you can't
> > do with a kernel module.
>
> It is good for experimenting with processor features.
>
> On an embedded system, it is often nice to turn off interrupts
> to do a bit of super-hard real-time from userspace. The user code
> may well be incompatible with the kernel. (non-GPL C++ or FORTRAN)

OK, I can buy that argument.  The way that Ed described that he
implemented this sounded to me like it maybe wasn't the best way to do
it but without seeing any actual code we can't usefully discuss it any
further.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
