Message-Id: <200007121112.MAA14217@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 12:12:08 +0100
Subject: Re: [ANN] Dmasound backport to 2.2.17pre7/10 patch
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 12, 2000, Derek Homeier wrote:
> On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:
>
[...]
>
> _But_ after some hours of sleep, the machine would not wake up properly.
> First, the backlight didn't switch on. I tried the usual tricks of playing
> with the brightness control, but to no effect. The machine was running at
> first, as I could tell from the usual disk activity caused by slocate.

are you using the sound stuff as modules? If so does the effect manifest
without sound loaded?  There is code in the sound stuff that talks to the
PMU...

which PB (if Lombard - I'll see if I can replicate the effect here).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
