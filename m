Date: Thu, 20 Apr 2000 20:45:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MiniDin9 serial pin outs to talk to DB9 UPS?
In-Reply-To: <38FF41D9.2BF99B00@chpc.utah.edu>
Message-ID: <Pine.LNX.4.10.10004201959250.20461-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Mac MiniDin9 by jumpering MiniDin9 pins 1 and 6 together. This didn't
> > > work. Nor did jumpering 1 to 8 or 1 to 7.
> >
> > Try connecting 1 and 2 ...
>
> I just gave connecting 1 and 2 a try and the results were no better than
> before. My UPS terminal program doesn't get anything back from the UPS. It
> just sits there spinning waiting for I/O without blocking apparantly as the
> user and system loads go up. Of course this UPS terminal program itself may

The terminal program may not be using long select timeouts or just short
sleeps. On the other end, the DB9 connector may need some pins jumpered.

The good old fashioned LED serial interface monitor may be the best tool
for debugging this :-) Would help to figure out if the UPS sends any data
at all, at least.

> Maybe I should jumper one of the other pairs you mention? Maybe I need to

I'll have to dig out the pinout first. And I'll search for descriptions of
a RS422-RS232 cable (should have come up on linux-mac68k before).

> change some stty parameters? Are there any other tools you could suggest to
> try talking with the UPS? I haven't tried just using "cat" or "tip" yet. Any

cu or minicom is what I use. If the serial port opens at all using those
tools stty should not be needed.

> thing obvious that I should avoid? I'll see if I can't drop a serial analyzer
> box in the middle some how to see what signalling is actually occuring.

That's probably most useful at this point. You'll at least see that the
Mac can send data to the UPS (hopefully) and thus the serial driver
doesn't choke on your wiring.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
