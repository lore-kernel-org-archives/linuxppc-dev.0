From: mutex@kerneli.org
Date: Wed, 23 Jul 2003 20:24:29 -0700
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new ATI sleep code freezes
Message-ID: <20030724032429.GC1987@heliosphan.linuxsymposium.org>
References: <E19O25a-0000Ej-00@piglet.grunz.lu> <20030607192713.GN1982@heliosphan> <1055016895.17021.74.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
In-Reply-To: <1055016895.17021.74.camel@thor.holligenstrasse29.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The permissions don't cause the crash directly, it's the fact that
> the X server has no way of dealing with the sleep without using
> /dev/apm_bios.

I was able to re-create this crash the other day entirely reproduceably.
If I unplug my USB apple mouse while the computer is in between sleeping
and running normally the crash condition i described occurs, namely:

> Usually, when the sleep operation completes, there is a quick
> screen power blank. Then about another 1.5 seconds of the LCD being
> illuminated, with what looks like some random part of video memory
> being displayed, then finally the machine goes to sleep. Occasionally
> I am seeing a freeze during the step where the machine stays on for
> 1.5 seconds and has not quite been put to sleep.

Maybe there's a deadlock somewhere in the USB layer sleep code ? I
haven't tried this with other USB devices, but I plan on doing that as
so on as I get back from OLS.

Regards,
Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
