Date: Wed, 23 Aug 2000 10:11:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: mlan@cpu.lu, geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org,
        dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A30138.36D33D93@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10008231008510.13478-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I don't think having to use ShadowFB with the fbdev driver is too bad
> > > because it should generally enhance performance :)
> >
> > I guess control is the exception. I found out it isn't worth the memory
> > impact. I once ran a complete x11perf run comparing with and without
> > shadowfb, and with shadowfb was overall slower. Some operations were
> > faster, though, but not in general.
>
> Oh no. This is very bad.

But that was on 4.0, not 4.0.1, right? shadowfb on 4.0 fbdev treated me to
a ~5sec delay on logout while that nice grey pattern was drawn line by
line. Someone said it was due to a bug in shadowfb... and I'd assume it
was fixed in 4.0.1.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
