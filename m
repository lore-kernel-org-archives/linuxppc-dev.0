From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200407261431.i6QEVWX15175@hofr.at>
Subject: Re: Linux is not reliable enough?
In-Reply-To: <004701c47317$073ce590$0301a8c0@chuck2> from Mark Chambers at "Jul
 26, 2004 09:46:58 am"
To: Mark Chambers <markc@mail.com>
Date: Mon, 26 Jul 2004 16:31:32 +0200 (CEST)
Cc: Marius Groeger <mgroeger@sysgo.com>,
	linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > On Sat, 24 Jul 2004, Mark Chambers wrote:
> >
> > > that the only way to prove reliability is with testing.  Linux is open
> > > source, it won't cost anything to put it on a side by side test, and let
> > > Linux speak for itself.
> >
> > Getting to the point where you can run this side by side test *will*
> > cost money, and typically rather much, what's more. It is not likely
> > that Kevin's customer is going to pay the implementation for two OSes,
> > even if it is only to the prototype stage.
> >
>
> Yes, a good point.  But I'm speaking with a salesman voice.  For someone who
> is an expert like Kevin he can no doubt prototype something fairly quickly,
> and getting the customer to see something actually working is very powerful.
> It puts the ball in the Chief Software Architect's (the CSA, hereafter :-)
> court to justify the additional expense of QNX.
>

prototyping and testing only can proof things if you
can reliably reproduce the rare failure cases - which limits
this posibility seriously. I guess nobody doubts
that Linux is stable under typical load situations (what
ever those may be..)

> > So, thinking about the right OS for the job in advance, as they do, is
> > a good idea. Only the thinking must be done right, of course :-)
> >
>
> Indeed.  I guess I should spell out what I think is wrong with the CSAs
> apparent thinking:  He points out an aspect of linux, namely that drivers
> can crash the system, as an issue that somehow makes linux intrinsically
> unreliable.  But if you write drivers that don't crash the system then linux
> is not unreliable.  The only operating system that doesn't allow a clever
> programmer to crash is one that doesn't do anything.  Microkernels, they
> say, allow you to do nifty things like replace the file system without
> rebooting.  So that means you could swap in a buggy filesystem and destroy
> the data on your disc/flash.  Without rebooting.  Which is good since you
> won't be able to boot from your corrupted filesystem, which won't show up
> until the next power failure, while the poor nurse with a flashlight talks
> to a guy on the phone who assures her QNX can't fail.  So every OS, and
> every feature, has its pro's and con's.  The question for any CSA is not 'is
> this reliable' but 'can I make a reliable system using this component'?
> Will the OS eat itself, or do I only have to worry about the mistakes I
> make?  A carefully constructed linux system should be good for 5 or even 6
> nines of reliability.

The issue is more the presenting of convincing
safty cases - and in that area QNX most likely has a easier game than
embedded Linux - not because Linux has less potential but because
it does not have the trak record for safty critical apps (yet)
And with the development speed of the Linux kernel a real
evaluation of the kernel is a non-trivial task - in that respect a
microkernel does have serious advantages if one can isolate components
, that is gurarty error-containment within a component, in a way that
composability is maintained even in the error case - this definitly will
be hard to do for Linux and most likely for QNX core components a lot of
this work has allready been done.

to summarize the problem - a quote from Rich Cook:

Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe
striving to produce bigger and better idiots. So far, the universe is
winning.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
