Message-ID: <398950D9.2373EC50@gmx.de>
Date: Thu, 03 Aug 2000 13:00:41 +0200
From: Matthias Pfisterer <Matthias.Pfisterer@gmx.de>
MIME-Version: 1.0
To: alsa-devel@alsa-project.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [alsa-devel] Re: ALSA sequencer + Timidity on GNU/Linux PPC
References: <200008030930.KAA12700@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> On  Thu, Aug 3, 2000, Matthias Pfisterer wrote:
> > I tried the above combination (plus pmidi). It generally works; timing
> > seems to be correct. However, the sound of most (all?) notes is very
> > distorted. Is there any way to debug this? Timidity in standalone-mode
> > works ok---some timing problems if doing real-time playback, but perfect
> > in doing batch-processing (rendering to a wav file).
> > I'm using alsa-drivers 0.5.8b, Timidity 2.10.0a3 and a patched dmasound
> > driver (that's the OSS driver for Macs, sorry, no ALSA driver for it
> > yet).
>
> Which kernel (2.2.17pxx or 2.4.0?)

2.2.17pre10-ben2 + your dmasound patch + my hacks. I wanted to clean up
by using Ben H. newest version, but found no rsync URL for the 2.2.17xxx
tree, only for 2.4.x. Anybody can send it me?

> (a) What frag sizes & number of frags are you using for the driver?

I started Timidity like this:
% timidity -c /etc/timidity.cfg -iA -B2,8

>
> (b) I think we may have an issue with the order in which SNDCTL_XXX IOCTLs
> are sent to the dmasound driver.  This is being investigated (today) as it
> came to light last night...
>
> It is possible that the distortion is simply that the mode that Timidity
> *thinks* it has set is different for what is *actually* set in the driver.
>
> Once the kernel (OSS) driver is "sorted" I will (if no-one else
> volunteers/does it in the meantime) try to get an ALSA one going ASAP.
>
> BTW I will try and replicate the effect if you mail me the configs/URLs
> (off-list).  Last time I tried Timidity I didn't get any action :-( but I
> had very little time to experiment.

Will do this in the  afternoon/evening. I'm in hurry now.

Matthias

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
