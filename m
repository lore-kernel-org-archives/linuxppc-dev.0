Message-ID: <38FF41D9.2BF99B00@chpc.utah.edu>
Date: Thu, 20 Apr 2000 11:43:53 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MiniDin9 serial pin outs to talk to DB9 UPS?
References: <Pine.LNX.4.10.10004201742100.19482-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> . . . Nope, you need to connect RTS and CTS, and sometimes DTR and DSR and
> DCD are also connected together. C onnecting DTR and TxD will only confuse
> the
> serial driver.

>
> > Mac MiniDin9 by jumpering MiniDin9 pins 1 and 6 together. This didn't
> > work. Nor did jumpering 1 to 8 or 1 to 7.
>
> Try connecting 1 and 2 ...
>
>         Michael

Thanks Michael.

I just gave connecting 1 and 2 a try and the results were no better than
before. My UPS terminal program doesn't get anything back from the UPS. It
just sits there spinning waiting for I/O without blocking apparantly as the
user and system loads go up. Of course this UPS terminal program itself may
not be comminicating correctly but at least it compiled without any warnings
(or errors). If communications works correctly the UPS terminal program says
that I should see an output string from the UPS doing something like
identifying itself. I don't see a thing though that appears to come from the
UPS.

Maybe I should jumper one of the other pairs you mention? Maybe I need to
change some stty parameters? Are there any other tools you could suggest to
try talking with the UPS? I haven't tried just using "cat" or "tip" yet. Any
thing obvious that I should avoid? I'll see if I can't drop a serial analyzer
box in the middle some how to see what signalling is actually occuring.

Thanks again. Any one else have any ideas?

--Lou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
