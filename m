Date: Wed, 13 Sep 2000 10:21:53 -0400 (EDT)
From: mberglund <matt@realestatesafari.com>
To: daenzerm@student.ethz.ch
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Roles for distributions
In-Reply-To: <39BF8519.427B985C@relog.ch>
Message-ID: <Pine.LNX.4.21.0009131006050.304-100000@europa.rcinfo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Michel [iso-8859-1] Dänzer wrote:

> mberglund wrote:
>
> > > > It also seems like the lost art of making an OS the SAME from platform
> > > > to platform is just that, LOST. This is another lofty goal in the
> > > > project.
> > > >
> > > > I mean, it is hard enough to learn a new hardware platform, without
> > > > having to learn a new version of linux(or unix, for that matter). And
> > > > even redhat has not been able to make thier distro the same from
> > > > platform to platform.
> > >
> > > With Debian being the only distribution that runs on all my boxes, I still
> > > have to find the differences among Debian on the different platforms that
> > > are not caused by actual differences in the hardware configuration.
> >
> > Well, the way you phrased this helps my point(and I am assuming that is
> > what you intended). This is exactly one of the big beefs my little band
> > has with the linux population right now. We hope to fix help fix it, want
> > to help?
>
> Please elaborate on this, I'm curious how you intend to fix the hardware
> differences. ;)

HarHar. :) The hardware differences, thenselves, cannot be fixed,
obviously. But when one goes to use a tool, this tool should, _act_ the
same on each platform, taking in to account the hardware differences.

A not-so-good example could be the kernel debugger. Please, PLEASE, do not
remind me about the debate that just raged across l-k about this. The kmon
debugger is one such critter, used by the ppc(and others?) folks. The kdb
is used by the Intel folks.

WHY ARE THESE NOT BEING MERGED??? The same tool, the same functions, a
developer on one system could then move to the other with little or no
difficulty using the debugger. Whoa.... no learning curve for the
tools? Damn, what an Idea? Thank the NetBSD folks. Its theres. And it
_does_ make some sense(to me anyway).

> I currently have no box to play with, but I also find the concept interesting.

If you are willing to work. We may be able to help you with that
problem. But it would be difficult to test your stuff, but do you do
remote work?

Later,
Matt

Unix is best described as an old, sturdy tree.
It is well structured, always growing, and has passed the test of time.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
