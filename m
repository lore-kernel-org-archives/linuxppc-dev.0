Message-ID: <3A243FA7.4EA8C037@mvista.com>
Date: Tue, 28 Nov 2000 18:28:39 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <Pine.GSO.4.21.0011281625590.493-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> Ok.  Do you know if there is anonymous bk access to the linuxppc_2_5
> tree?  If so, on what port?

I think so, 5005 comes to mind.  Search the linuxppc-dev archives
for some references.

> As an off topic side note, wouldn't it make sense for there to be a common
> MII library for all linux network drivers to share?  Is this not possible,
> or has no one volunteered yet?

I don't ever remember such a discussion.  If it made sense, you would
see it in the generic network drivers, but it's not there.  Logically,
it makes sense, but you will notice the implementations are quite
different because of the hardware.  Even the 860 and 8260 are different.
The 860 has an interrupt driven piece of hardware, while the 8260 is
single threaded software bit shifting.  The support functions are quite
different because of this (which is why I am not using any of the 860
functions in the 8260 driver).  If you have time, take a look at it.
Just remember simplicity wins....I'm sure you can force some kind of
"common functions" if that is your goal, but if it's a complicated
spaghetti mess that only you understand it doesn't help :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
