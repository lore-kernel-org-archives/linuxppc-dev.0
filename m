Message-Id: <200008241630.RAA14789@hyperion.valhalla.net>
Date: Thu, 24 Aug 2000 17:30:29 +0100
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: daenzerm@student.ethz.ch, Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Where is your backport (or rather patches against 2.4.0-testx) available?

The backport is on  http://www.drfruitcake.com/linux/linuxppc.html

I have not done a separate 2.4.0-test x patch.

The reason is that the code *is* the 2.4.0-testx code. (this was the point
of the back-port) with a few KERNEL_VERSION conditionals

So, if you want to use it on 2.4.0 all you should need to do is to replace
the files in drivers/sounds/dmasound with the ones from the back-port.

There are a few minor additions (DSP_SND_GETCAPS etc.).

If people want a 2.4.0 patch I'll do one... but it's been awful quiet
(s'cuse the pun).

I'm mostly working under 2.2.17 because of the flakiness of 2.4.0 (but, by
using the same code base, with the idea that any improvements will move
straight to 2.4.0)>

There are things in progress to sort out mixer abstraction issues with
different pmac models.  Wrestling with via-cuda :-( trying to read the i2c
bus (with some action but still some problems)..

and...
I've also been "underactive and out of touch" as well :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
