Date: Wed, 13 Sep 2000 09:54:30 -0400 (EDT)
From: mberglund <matt@realestatesafari.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Graham Stoney <greyham@research.canon.com.au>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        Todd Lipcon <tlipcon@mercea.net>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Roles for distributions
In-Reply-To: <Pine.LNX.4.10.10009130005120.372-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0009130936320.304-100000@europa.rcinfo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, Geert Uytterhoeven wrote:

> On Tue, 12 Sep 2000, mberglund wrote:
> > It also seems like the lost art of making an OS the SAME from platform to
> > platform is just that, LOST. This is another lofty goal in the project.
> >
> > I mean, it is hard enough to learn a new hardware platform, without having
> > to learn a new version of linux(or unix, for that matter). And even redhat
> > has not been able to make thier distro the same from platform to platform.
>
> With Debian being the only distribution that runs on all my boxes, I still
> have to find the differences among Debian on the different platforms that are
> not caused by actual differences in the hardware configuration.

Well, the way you phrased this helps my point(and I am assuming that is
what you intended). This is exactly one of the big beefs my little band
has with the linux population right now. We hope to fix help fix it, want
to help?

And if debian is perfect across all the platforms, great! The update
system is still not what we want. And if you try the other, you might be
suprised at how much you may like it. Go plop FreeBSD on a system ,and
wait a few weeks, and then do an update. They have a _good_ idea. All I am
saying is lets try to use it. There is not ONE good reason that I have
found not to make the attempt. And we have a working system. No boot disks
yet, but a working system.

> FYI, I have experience with Debian on ia32, m68k, PPC, AXP and even MIPSEL.

Ohhh, Alpha!! Can I have one? :>

I only have experience with ia32, PPC, m86k, and S390 on hercules(with
a real S390 on the way). I have tried all of the major distributions and
some of the smaller ones. Rock has some good ideas, but it seems that they
are trying to use shell scripts for almost everything instead of the
make(8) system. Why not use a tool that is far more standard, and designed
for the purpose?

If you guys have some interesting ideas, we want to hear them. The
darkstar project can be found at darkstar.fxp.org. There is a _lot_ of
work to be done, and frankly, I am not the guy to do alot of it. There's a
buddy of mine who is far better programmer than I and has done much of the
work already. We need help. Get on the mailing lists, if you'd like.

The goals are straight forward, the mechanism is working. We need more
competent hands. And when Chris and I are satisfied, you'll get commit
privlidges directly to the tree. This is NOT simply a kernel project, but
an OS project. Keep that in mind.

Later,
Matt

Unix is best described as an old, sturdy tree.
It is well structured, always growing, and has passed the test of time.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
