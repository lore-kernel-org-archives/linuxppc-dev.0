Message-ID: <382C1D65.205953EE@erols.com>
Date: Fri, 12 Nov 1999 09:00:05 -0500
From: Erik Winkler <ewinkler@erols.com>
Reply-To: ewinkler@erols.com
MIME-Version: 1.0
To: happyoscar42@usa.net
CC: "Momchil 'Velco' Velikov" <velco@fadata.bg>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT] dual 8500
References: <199911121056.CAA08039@marcus.pants.nu> <382B2359.51B1F11A@usa.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I used a dual-180 Daystar card in my 8500 and it worked great.  Yes, the
memory interleaving did help a lot under Linux as David notes below.
You'll want to get an SMP kernel from
ftp://borg.mit.edu/pub/linux/ppc/kernels/multiprocessor/ and then compile
your own at some point.  These kernels worked for me.

Erik

David Riley wrote:

> Brad Boyer wrote:
> >
> > Momchil 'Velco' Velikov wrote:
> > > Does anyone of you have any experience (either good or bad)
> > > with PowerMac 8500 with dual-processor card and Linux ?
> >
> > I have both good and bad experiences with dual processor cards,
> > although I was using a 7600.  When it works, it is wonderful, but
> > it occasionally gets confused in interesting ways.  It seems to be
> > very sensitive to everything, and I had to rearrange the RAM in
> > the slots to get Linux to work.  It somtimes requires the MacOS
> > extensions to load to reinitialize stuff if it crashes in a bad
> > state.  It will make Linux much faster, tho.  I replaced a 132MHz
> > 604 board with a dual 200MHz 604e one and it was a very nice change.
>
> Oh yes, there is something you should know.  When you install the MP
> card, you WILL want to interleave your RAM.  You'll want to do it
> anyways, because the PowerPC is able to do double-bandwidth bursts if
> you interleave identically sized dimms.  On linux, since the OS runs
> both the processors in an efficient manner (unlike the MacOS) this is
> more or less required for an MP card.  On the MacOS, it will result
> mostly in a speed boost (this includes single processors, too).
>
> > > I intend to obtain one, but I definitely want to run
> > > Linux on it. I don't care much if MacOS doesn't work
> > > on such a machine.
> >
> > They work fine in the MacOS, but you won't see much improvement
> > on most things.
>
> In general, the MP cards work better on the MacOS than in linux (most
> things do, because almost everything in linux is still more or less
> under development).  However, only recent versions of the OS even take
> advantage of MP cards, and the only MP-enhanced program that I know of
> is Photoshop.
>
> --
> --"Your mouse has been moved.  Windows 95 must be restarted for change
> to take effect."


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
