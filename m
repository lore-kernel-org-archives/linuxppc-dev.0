Message-Id: <200007252142.WAA27135@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 22:41:05 +0100
Subject: Re: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Steffen,

I think we should take this off-list... (it's getting to be a bit
long-winded)...

Ben, Franz (if you are 'listening' or have an interest) let me know and I'll
cc you otherwise we'll report back when there's some solution.

>>1. what does dmesg now show?
>
> DMA sound driver core [Ed 3]

Good that's definitely the back-port code...

> 4 Buffers of 32 K for Output
> Same for Input

You've abbreviated this (I hope)...

> AWACS rev 100
>
> registers:
>
> 1400 782d 7810 0001 00a1 0021 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 4000 0000 26bb 0010 0000 0002
> 0001 0000 0000 0000 0000 0000 0000 0000

Good, it's recognised your Burgundy chip...

>>2. have you tried headphones/versus built-in speaker?  (others have reported
>>a problem here - which is why the finger of blame is currently pointing at
>>the mixer abstraction)...
>
> Up to now only built-in speakers. Will try with headphones :)
>
[snip]

The rest looks OK too...

Now, I'll have a quick look at the amp-enable code (again) - that did have a
problem at one point.

I'm out (on paid work :) tomorrow... so not much action 'till late...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
