Message-Id: <200003230219.CAA29901@hyperion.valhalla.net>
Date: Thu, 23 Mar 2000 02:20:00 +0000
Subject: Re: State of sound support in 2.3.x
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: jingai@floatingpenguins.com
CC: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have the 2.3.52 kernel from Paul's tree, with PowerMac DMA
> sound support compiled in.  I guess my question is:  what is the current
> state of sound support in Paul's 2.3.52 kernel?

My primary distribution source is also LimuxPPC.

Geert Uytterhoeven posted a patch to split the DMA sound support between
Pmac, Atari etc. a while ago (look for dmasound split).

If you can't find it, I have a copy of the URLs to fetch it, somewhere.

It works against 2.3.52 [Paul's tree] (with a small additional mod to
drivers/char/mem.c)

With the patch, 44.1k wav files >/dev/dsp work on G3(beige Minitower) & G3
Lombard + possibly some others...

I am still trying to get to the bottom of why it doesn't on a 9600 [>50%
chance that it's an unrelated problem] and checking out other formats.

I haven't tried very hard to do anything without the patch.

Theme Sound under KDE (1.1.1) seems to be broken with or without the patch
(apart from Beep) - but that's probably a 2.3.xx issue.

As for other issues e.g. whether OSS stuff works - well I never got the
sequencer to work yet [under 2.2.6-apmac15, 2.2.14p9 or 2.3.xx] (but I
didn't try very hard yet ;-)

Once I understand the issues better I am going to try an ALSA driver for the
pmac built-in sound (it might help you because ALSA has support for the
'legacy' sound methods - which might bring more of the x86 stuff into view).

P.S. I'm pretty new to this particular kernel... so there's probably loads
more to add.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
