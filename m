Date: Wed, 28 Mar 2001 11:28:33 +0100
Subject: console IRQ block fix.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org, cort@fsmlabs.com
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328102833.CAC60DB9C9@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mon, Mar 26, 2001, Geert Uytterhoeven wrote:
> On Mon, 26 Mar 2001, Iain Sandoe wrote:
>> [Geert, Cort - the question for you guys is "has the Console IRQ block been
>> solved?" - I was under the impression it had from some traffic on
>> Linux-audio-dev]
>
> According to Andrew Morton it is. That's all I can say :-)

hmmm. well, as of -pre8 pulled last night my g3/beige (atyfb) still blocks
for >1.9 seconds on console scroll. *ouch!*.

Andrew's position (according to a post on linux-audio-dev & lkml) is that
the console block fix is a "bug fix" rather than an "audio enhancement"

- is it likely to make it into the PPC tree?

- I will try AM's patches again soon (they helped before, but still left
some 100-300 ms blocks in place on PPC - whereas they take scheduling
latency below 1ms on x86)...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
