Date: Sun, 13 May 2001 17:03:26 +0100
Subject: Re: Kernel sound problems (and misc)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Bastien Nocera <hadess@hadess.net>,
	LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010513160247.E08682F05C@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Bastien,

> Ben's tree seems to already include Iain's dmasound patches, and showed
> the same problem as when I applied the patches on an older kernel: when
> booting (ie. when the sound is activated), the speakers are "hissing"
> until I play something and stop it. Then it behaves correctly (ie.
> there's no sound when I'm not playing any :P)

Hmmm. I've obviously done something that means that dma is *not* halted on
your machine at startup.  This should be fairly easy to fix (but I'm away
for a week - so next weekend).  It doesn't happen on any of my machines - so
perhaps something specific to burgundy.

I don't know why this didn't make sense to me before ...

I will look at this next w/e and send you a patch to test (unless someone
else does it first ;-)

> OK, there goes the main problem: mixer problems. There are 3 ways to
> output sound on this iMac DV summer 2000 (OF tree still available from
> tidbit.org).
> - the front speakers: the preferred way obviously. Main volume is of no
> use (doesn't do anything), the speakers volume goes from mute, or loud
> to very loud.
> - the front audio sockets: there aren't independant of the front
> speakers, doesn't really matter, but that means it's not possible to
> shut the sound of the speakers and listen to the music with a headphone.
> It might be a hardware problem.
> - the audio socket for external speakers on the left handside of the
> machine: there's no volume control for them. Bringing down all the
> volume controls shut off the front speakers (good), but there's no way
> to raise or lower the sound on this output either.
>
> So, to sum it up, the main volume control does absolutely nothing on
> this machine, and the speaker volume control is either mute, loud, or
> very loud. I'd be glad to help on finding out the problem.

This is, presumably, no change from the 'standard' version.

This because there is still quite a lot of work to do on the iMac stuff -
and we've only had the Darwin info for a little while ... I can only offer
two solutions:

1. patience ...
2. send me a patch that fixes it ;-)))

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
