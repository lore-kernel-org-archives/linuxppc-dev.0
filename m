Message-Id: <200007161155.MAA19420@hyperion.valhalla.net>
Date: Sun, 16 Jul 2000 12:55:57 +0100
Subject: update: ppc IRQ blocking.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: jsun@mvista.com
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Well, much of the info presented in my message yesterday was bogus...

The instrumentation needs improvement... it's missing too many cases where
IRQs are switched on/off behind the back of the measurement (which is making
it very difficult to narrow down the rogue...)

I'm working on it.

The latency measurements *do* indicate a problem... I don't think that is
bogus.. but...

So unless:
(a) you have an idea where there might be a 8 to 10ms hold off in IRQ or
(b) you already have an IRQ blocking measurement set that includes all the
cases (in which case I'd love a copy ;-)

Ignore the post of yesterday...
Iain.

P.S. Jun - do you want a copy of what I've got so far? or wait 'till it's
done... I covered a lot more cases but still need to deal with all the stuff
going on in head.S :-(


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
