Message-Id: <200007121137.MAA18130@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 12:37:04 +0100
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----------
>From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
>To: Iain Sandoe <iain@sandoe.co.uk>
>Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
>Date: Wed, Jul 12, 2000, 12:27
>
ON Wed, Jul 12, 2000, Derek Homeier wrote:
> On Wed, 12 Jul 2000, Iain Sandoe wrote:
[...]
>>
>> which PB (if Lombard - I'll see if I can replicate the effect here).
>>
> Yes, Lombard 333 MHz standard configuration.

OK - I'll get to this later - wrestling with 2.4.0 right now...

> I did compile dmasound as module (I noticed that after applyiing your patch,
> dmasound was unselected in .config - is there a reason for this?).

Yes, the CONFIG_DMASOUND changed to a set of CONFIG_DMASOUND_XXXX for the
various different platforms.  Note there is no such thing as 'dmasound.o'
any more :-)

you have to modprobe:
soundcore
dmasound_core <params>
dmasound_awacs

> I will test this, though I'm not sure if it's easy to reproduce -
> if it takes a prolonged time of sleep for the effect to come up...

well, it would be nice to narrow down where it lies...
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
