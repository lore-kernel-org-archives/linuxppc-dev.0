Date: Tue, 24 Jul 2001 18:07:57 +0100
Subject: Re: Sound stoppage on PowerCenter 132
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michael R. Zucca" <mrz5149@acm.org>,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010724170743.3D847DB9C5@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michael,

> Ok, it's been a long time since I last posted. I've been busy :-)

tell me about it :-(((

> I rsync'd the benh-2.4 tree from 7/24 and compiled it. I checked the awacs
> driver and it seems to contain the code which handles the DMA DEAD
> condition.
>
> The problem still seems to be the same. If I play an mp3 using mpg123, the
> song plays fine. However, if I introduce enough PCI traffic (like, say,
> opening up Netscape in X for my ATI PCI video card), the song stops dead
> (no sound) but the mpg123 seems to stick around, presumably waiting on the
> device.

*sigh* ... well, as the comments say, - it was a trial - I have no h/w to
test on ...

> The code "seems" more robust under X but that could just be my imagination.
:-)

actually, it should be (generally) more robust ... (but that might be just
my sales-pitch ;-))

> BTW, I have a PowerCenter 132 with a 750 upgrade in it, if that makes any
> difference.

I don't think that the 750 makes any difference - the problem is out in IO
land (AFAICT).

OK.  I want to fix this (there are a few PowerCentre users out there)...
but I need someone with h/w to help me ...

You need to enable DEBUG_DMASOUND and rebuild the modules ... it should then
put (at least a little) stuff out to the console saying what it's trying to
do ...

I'm considering re-jigging the IRQ code in dmasound_pmac anyway (to make SMP
handling more sane)....

I don't (at the moment) have much linux time available ... but I'll have a
go (or make suggestions of things to try - if you can test it)...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
