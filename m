Date: Wed, 9 Dec 1998 01:30:02 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Dan Malek <dmalek@jlc.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.04.9812090128220.13527-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Dec 1998, Cort Dougan wrote:

> The hardware is more stable, of course, but we can miss when handling it.
> Take a look at the decrementer code - I think it's possible to miss a decr
> when resetting it.  That could explain drift.

Okay, would this cause the clock to be fast? (mine was about 45 minutes
fast) (And, is it feasable to make it 'impossible' to miss a decr?)

I have also rebooted the machine quite a bit.. This may also be the
reason.

> 
> }Nope, not even close.  If you convert rtc drift specifications and
> }processor oscillator drift specifications to a common reference (like
> }PPM) you will see processor oscillators are significantly better
> 
> 

Basically, I want to know the right way to do this before fixing it.

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
