Subject: Re: R128 Scaling.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <87662rrcry.fsf@hades.nocrew.org>
References: <878z7nuamf.fsf@hades.nocrew.org>
	<1018963230.1590.2438.camel@tibook>  <87662rrcry.fsf@hades.nocrew.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Apr 2002 15:40:31 +0200
Message-Id: <1018964431.1590.2722.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-04-16 at 15:30, Stefan Berndtsson wrote:
>
> > Note that fullscreen doesn't require DGA per se. Direct framebuffer
> > access is generally slow, xmame might be better off using normal X
> > images or pixmaps and relying on an optimized ImageWrite acceleration in
> > the driver.
>
> I know you technically, don't need DGA for fullscreen, but afaik, MAME
> supports -x11-mode 0 or 1, where 0 is window, and 1 is DGA. Comparing the
> two on a stationary machine, where LCD-scaling isn't an issue, DGA is
> faster in every case.
>
> Also comparing small SDL-hacks in the same environment, DGA beats non-DGA
> hands down.

Is that with a driver with optimized ImageWrite acceleration? I don't
think any stock XFree86 driver is really optimized there yet, I'm
working on radeon now and the results should be easily applicable to
r128.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
