Message-ID: <3A5C21C2.DE5C4489@petig-baender.de>
Date: Wed, 10 Jan 2001 09:48:02 +0100
From: Christof Petig <christof@petig-baender.de>
MIME-Version: 1.0
To: Conrad H Ziesler <cziesler@umich.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook sound, limping mixer
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Conrad H Ziesler wrote:

> in case this is of any use to anyone:
>
Yes, I'm very interested. Since I actually started looking into the
specs and sources, but did not find the time to start coding the same.


> it all seems simple enough.  i hacked up a simple i2c driver merged into
> the mixer code from above, cut apart dmasound to eliminate the mixer
> device and extraneous stuff,
>
can you send me a patch?

> and added the appropriate missing
> KL1_AUDIO_XXX and KL1_I2S_) bits to arch/ppc/kernel/feature.c (in
> feature_bits_keylargo[], under FEATURE_Sound_xxx  so the daca gets powered
> up)
>
> then i rebooted and had sound and a mixer device, and was able to
> hear some sound, fiddle with the mixer controls, and then hear no sound
> once or twice i was able to reenable sound by randomly fiddling with the
> mixer.
>
> so apparently SOME data was getting across the i2c bus to the daca chip,
> but probably it was reading trash.
>
Hmm. I first thought it might be an byte order issue but then realized
it would only swap left and right volume. No idea yet. I'll give it a
try myself later.

>
> since the dac3550a has write-only i2c registers, its pretty hard to debug
> the i2c interface.  probably if someone puts an oscilloscope probe on the
> i2c bus signals it should all become clear.
>
I would recommend a logic analyzer or better an i2c analyzer. I have an
oscilloscope but I would not dare to try reading i2c signals by hand.

Christof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
