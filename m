Date: Wed, 10 May 2000 10:43:41 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Lombard hard freeze (update: mem>64MB)
In-reply-to: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE>
To: Bernhard Reiter <bernhard@intevation.de>, linuxppc-dev@lists.linuxppc.org
Message-id: <p04301800b53f4fdb650f@[134.114.64.236]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It would so nice to have a person who can debug it.
>I will test two things:
>	Setting mem=64M and see if it makes it stable.
>
>	Maybe a development line kernel has some fixes for this stuff,
>	I shall try one.
>
>Maybe we should ask for Lombard users which have a stable system
>with more as 64MB memory. Can they do huge compiles?
>Somebody should have a lombard the symptom and the guts to debug it.
>
>	Bernhard

I've been paying attention to this thread for a while since I have a
Pismo and mine is exhibiting the same problems that yours is.  I have
128M of RAM in mine (one stick).  This is memory straight from Apple.
I also see kernel panics/lockups during large compiles.  I managed to
make it through KDevelop 1.2, but it will ALWAYS die during XFree 4.0.

Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
