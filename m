Message-ID: <3C029CAC.761E2AB@netfall.com>
Date: Mon, 26 Nov 2001 11:49:00 -0800
From: Andrew Sharp <andy@netfall.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Kernel crashing problems on oldworld
References: <20011123032512.C387@Obsession> <3C00772F.783F8720@netfall.com> <20011125180959.B203@Obsession>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Tillman wrote:
>
> On Sat, Nov 24, 2001 at 08:44:31PM -0800, Andrew Sharp wrote:
> >
> > Chris Tillman wrote:

> > > Another interesting point is that I can run all the ncurses test
> > > programs except worm, which crashes in a few seconds, but only when
> > > the console it's running on is actually visible. And, the blink and
> > > underline attributes don't seem to work on my system.
> > >
> > > Finally, I downloaded the kernel-image-2.4.12-powerpc package to see
> > > if changing the kernel would make a difference. It did, the nano crash
> > > disappeared. The worm crash is still present, though.
> > >
> > > I can continue trying to trace the problem in worm, if there's
> > > interest, since it's present in both kernels. Or if there's interest
> > > in the kernel 2.2.19 nano problem, whatever... I am interested in
> > > helping track down the problem because it's such a hard crash. My
> > > filesystem is of course damaged when I have to hard reboot.
> > >
> > > I signed up to the list. Let me know what I can try. And Happy
> > > Thanksgiving!
> >
> > Thanks.  Are you sure it's not just some memory that's gone bad
> > rather than a conflict with the video card?
> >
>
> Well, I don't know how it could hit the same memory location at
> exactly the same time over more than 50 attempts (each time rebooting)
> and using two different released versions of the program plus my own
> compiled versions with debug statements added. Or could it? How would
> I test that?
>
> I wonder if the video card could be moved to the PowerCenter machine
> to see if the problem follows it? Probably not... The other machine
> does have a different card.

It may be an entire bank or line or whatever, not necessarily a
particular single addressed location.  You can try removing
individual sticks of memory, or moving memory around to your other
boxes to see if the problem follows any particular stick.

a


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
