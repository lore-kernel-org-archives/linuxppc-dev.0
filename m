To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT] 7450
References: <XFMail.010309095914.pochini@shiny.it>
	<3AA92A2C.1BC447B4@mvista.com>
	<8x4rx1bqq3.fsf@s62.informatik.uni-bremen.de>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 15 Mar 2001 14:05:53 +0100
In-Reply-To: Holger Bettag's message of 10 Mar 2001 16:15:00 +0100
Message-ID: <8x7l1ri3m6.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag <hobold@Informatik.Uni-Bremen.DE> writes:

>
> Dan Malek <dan@mvista.com> writes:
>
> > Giuliano Pochini wrote:
> > >
> > > I read many msg about 7450 performance problems.
> >
> > From who?  People that are actually running hardware or
> > speculating from rumors based on documentation that doesn't exist?
> >
> There are some Mac benchmarks flying around, which don't make the 7450
> look all too good.
>
I got some more info on this issue and currently it seems that some
benchmarks are penalized not by the CPU core, but by the rather slow
L3 speeds. Apparently, the external L3 runs at a quarter of core speed
for the current high end G4 Macs; i.e. 166 and 183 MHz for the 666 and
733 MHz models, compared to 266MHz L2 of the 533MHz model.

I have heard of examples of both branch intensive and FPU intensive code
where the 7450 is faster per clock than the 7400, as long as the working
set fits in the on-chip caches.

The currently available docs from Motorola say that no L3 configurations
can be tested that result in speeds over 200MHz. This seems to be a
limitation of the testing procedure/equipment.

Is someone out there running the 7450 in non-Apple environments? What L3
configurations are used there?

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
