To: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: R128 Scaling.
References: <878z7nuamf.fsf@hades.nocrew.org>
	<1018963230.1590.2438.camel@tibook>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 16 Apr 2002 15:30:57 +0200
In-Reply-To: <1018963230.1590.2438.camel@tibook>
Message-ID: <87662rrcry.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer <michel@daenzer.net> writes:

> On Tue, 2002-04-16 at 13:49, Stefan Berndtsson wrote:
> >
> > When running XF4.2, without UseFBDev, scaling is no longer available, which
> > makes sense if it's a patch in the framebuffer.
>
> XFree86 4.2 does support scaling on its own, but you need to provide it
> the panel resolution, as should be visible in the log.

Ok.. I will have a look at that. I noticed all DGA using programs makes the
X-server crash when the programs exit, on your XF4.2.

> Or maybe it wrongly uses a 640 pitch? The virtual width is always 1024.
>
> This could be a bug either in the X driver's DGA support or xmame.

Could very well be. The DGA-hack is another patch floating around somewhere
that fixed some basic DGA stuff on the ibook2, but was known to crash
from time to time.

> Note that fullscreen doesn't require DGA per se. Direct framebuffer
> access is generally slow, xmame might be better off using normal X
> images or pixmaps and relying on an optimized ImageWrite acceleration in
> the driver.

I know you technically, don't need DGA for fullscreen, but afaik, MAME
supports -x11-mode 0 or 1, where 0 is window, and 1 is DGA. Comparing the
two on a stationary machine, where LCD-scaling isn't an issue, DGA is
faster in every case.

Also comparing small SDL-hacks in the same environment, DGA beats non-DGA
hands down.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
