Date: Sun, 30 Jul 2000 09:01:11 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stealth port problems
In-Reply-To: <200007301300.OAA07050@hyperion.valhalla.net>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000730083557.1508G-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Iain Sandoe wrote:

> > Ok, this is a news to me.  I'm certain that SCC on oldworld pmacs is
> > 85C30.  When did the change to 85230 occur?  If I remember correctly,
> > some DMA setup codes in macserial.c need to know about it if it's dealing
> > with 85230 rather than 85C30.
>
> OK - I don't know for certain - but the code refers to an "ESCC" which is
> the name of the 85230 - the 8530 should just be called "SCC".

It's not 8530.  I got an impression from Zilog's manual that ESCC refers
to both 85230 and 85C30 loosely.  Actually, on some pages, the term was
used to refer to functionalities only available on 85230, and, on other
pages, it was used to describe something 8530 doesn't support but both
85C30 and 85230 do.  AMD's usage of the term ESCC is yet slightly
different, IIRC.

Anyway, Apple's documentation uses the term ESCC and 85C30
interchangeably, and I think the driver's usage of the term "ESCC" comes
from there.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
