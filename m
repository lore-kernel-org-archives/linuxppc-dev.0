Message-ID: <39A3899A.CA375CE8@relog.ch>
Date: Wed, 23 Aug 2000 10:21:46 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: mlan@cpu.lu, geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org,
        dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.10.10008231008510.13478-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > > I don't think having to use ShadowFB with the fbdev driver is too bad
> > > > because it should generally enhance performance :)
> > >
> > > I guess control is the exception. I found out it isn't worth the memory
> > > impact. I once ran a complete x11perf run comparing with and without
> > > shadowfb, and with shadowfb was overall slower. Some operations were
> > > faster, though, but not in general.
> >
> > Oh no. This is very bad.
>
> But that was on 4.0, not 4.0.1, right? shadowfb on 4.0 fbdev treated me to
> a ~5sec delay on logout while that nice grey pattern was drawn line by
> line. Someone said it was due to a bug in shadowfb... and I'd assume it
> was fixed in 4.0.1.

This is GNOME, right? There has been discussion about that on an XFree86 list
(if it was Xpert, you can search the archive if you like), it's a GNOME bug.
It used stippled rectangles to draw that, which led to the whole rectangle
area being considered updated and copied from the shadow framebuffer to the
real one.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
