Date: Wed, 11 Oct 2000 21:09:08 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
Subject: Re: dual head r128
To: Josh Huber <huber@mclx.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Message-id: <39E4BAD4.E78B4E3B@student.ethz.ch>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20001011141722.A1437@missioncriticallinux.com>
 <39E4B4D0.FA62D929@student.ethz.ch>
 <20001011145249.B1437@missioncriticallinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:

> > Have you built X yourself? If yes, you need patches from Ani Joshi. The
> > memory and clock values it probes are obviously bogus.
>
> > Wait a minute, I see you are using debs, which should contain Ani's stuff.
> > Does aty128fb work on the second card? If yes, try Option "UseFBDev".
>
> Yeah, I'm using the debs, but it looks like the latest xserver-xfree86
> ppc packages are still at phase2v5, while the other packages are up to
> phase2v15.  Perhaps the code is just a little too old?

I guess it's because Branden doesn't build the powerpc debs himself or Ani's
patches didn't apply cleanly anymore.


> BTW, no...I don't have aty128fb working on the secondary head -- is
> there some option to tell the driver to scan for all cards?  does it
> do this by default?

I think you need to add a second video=aty128fb and/or video=map:000001 or
similar. Oh, and while we're at it, maybe you also need the libfbdevhw.a from
http://n.ethz.ch/student/daenzerm/download/X4-fbdev-test.tar.bz2 for the
second head to work with fbdev.


> The secondary card is a PC card, so it's not initialized by OF, but I
> think the r128 fb driver does a proper initialization of the card, so
> that shouldn't be the problem.

AFAIK it may be a problem with 2.2 kernels (for aty128fb) though.


> btw, I'm using the debian kernel that shipped with potato -- perhaps I
> should try a newer one?  ben's or a 2.4 kernel perhaps?

That might be a good idea at any rate.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
