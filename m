Date: Thu, 1 Apr 2004 10:19:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Proposed Kconfig update patch for help text)
Message-ID: <20040401171956.GD26876@smtp.west.cox.net>
References: <20040401161622.GA26876@smtp.west.cox.net> <20040401170515.E5C8EC10A4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040401170515.E5C8EC10A4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 07:05:10PM +0200, Wolfgang Denk wrote:
> In message <20040401161622.GA26876@smtp.west.cox.net> you wrote:
> >
> > In all seriousness, when the 52xx code for 2.4 was brought up, there
> > were a number of objections to the Motorola provided code, from it's
> > buggy to it being unacceptable crap.  Finally, 2.4 is about to enter a
>
> So far, it's all we have, right? Or do you have anything significant-
> ly better?

As I said, someone is working on the second option I described, but I
don't know how far they have gotten.

> > "deep freeze", or so Marcelo intends at least, so I think it's out of
> > the question for the mainline.  I don't mind keeping the
>
> So why made you me submit all the stuff in the first place  when  you
> were going to put it on hold until it was too late for inclusion?

When I asked, there was time.  Once I started trying to get people to
review it (since that's what upstream people like, and it's good
practice) it became apparent that the code wasn't in good enough shape
to get in.

> > For 2.6, I think one of the following options needs to be done.
> > - Motorola code, cleaned up with input from the community (and the bits
> >   Linux just doesn't need, left out).
>
> I think this is the only option there is.
>
> > - Ignore the Motorola code, or since it's GPL (must be to be in the
> >   kernel, so I'm just making the assumption here...) use it as a guide
> >   for how things work to implement a clean Linux implementation of the
> >   code.   I know there's someone working on this (who pops up on
> >   #mklinux on freenode from time to time) but I don't know how far
> >   they've gotten.
>
> Ummm... Why is there no discussion about this on  any  mailing  list?

There was some discussion in the same thread where people like benh
pointed out how bad the code is.  And there's a discussion right now,
right here even.

> And don't you think that that at least Motorola should be included in
> any  such  attempts? [AFAICT they are not, at least not until today.]

Well, Kumar is cc'ed here, and he's even on #mklinux on freenode where
Paul, benh, myself, and a lot of other people (including the person who
I suspect is on this list, but I don't know) who're working on 5xxx for
2.6 support, without the Motorola code.  If there's a specific person at
Motorola who'd be interested in what the Linux community has to say
about the DMA code, no one has told me who.

> Also, isn't this kind of wasted effort as the target is still moving?

What target?  The Motorola code?  The 5xxx hw line?  If you're talking
about kernels, the only non-moving target right now is 2.2, but I don't
think you're talking about that.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
