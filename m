Message-Id: <200008030930.KAA12700@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 10:30:48 +0100
Subject: Re: [alsa-devel] ALSA sequencer + Timidity on GNU/Linux PPC
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: alsa-devel@alsa-project.org, "alsa-devel" <alsa-devel@alsa-project.org>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Thu, Aug 3, 2000, Matthias Pfisterer wrote:
> I tried the above combination (plus pmidi). It generally works; timing
> seems to be correct. However, the sound of most (all?) notes is very
> distorted. Is there any way to debug this? Timidity in standalone-mode
> works ok---some timing problems if doing real-time playback, but perfect
> in doing batch-processing (rendering to a wav file).
> I'm using alsa-drivers 0.5.8b, Timidity 2.10.0a3 and a patched dmasound
> driver (that's the OSS driver for Macs, sorry, no ALSA driver for it
> yet).

Which kernel (2.2.17pxx or 2.4.0?)
(a) What frag sizes & number of frags are you using for the driver?

(b) I think we may have an issue with the order in which SNDCTL_XXX IOCTLs
are sent to the dmasound driver.  This is being investigated (today) as it
came to light last night...

It is possible that the distortion is simply that the mode that Timidity
*thinks* it has set is different for what is *actually* set in the driver.

Once the kernel (OSS) driver is "sorted" I will (if no-one else
volunteers/does it in the meantime) try to get an ALSA one going ASAP.

BTW I will try and replicate the effect if you mail me the configs/URLs
(off-list).  Last time I tried Timidity I didn't get any action :-( but I
had very little time to experiment.

regards,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
