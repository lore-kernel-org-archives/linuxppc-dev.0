Message-ID: <3926CD15.441C87AB@embeddededge.com>
Date: Sat, 20 May 2000 13:36:21 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Seungdong Lee <sdlee@da-san.com>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seungdong Lee wrote:
>
> Hi Dan, I have successfully ported Linux to my customized 8240 board.

Cool!  Good job.  What version of software are you using?  Did you
make any changes or want your board part of the kernel tree?

> Linux runs fine, but I found that the performance is not as good as my
> expectation.

Is this just based on the BogoMIPS number, or do you have some
benchmarks for comparison?

> BogoMIPS value of my board is currently 131.89.

I have not booted my 8240 for a while, and I don't remember the number.
I have another 8240 showing up soon, so I will be back on that before
long and will pay attention to this.  For some reason, I do remember that
with caches disabled this number is _really_ small, like 13 or 18 or
something.

I don't believe any absolute number here.  I just use it for a quick
reference when I am testing various cache combinations to indicate
that I am booting the kernel I wish to be using.

If this doesn't seem correct, ensure the processor is really running
at the clock rate you expect.  Verify external clocks, PLLs and the like.
Also, make sure the timers used to determine this value are properly
programmed.  One test I always perform is to run 'sleep 10' at the
shell prompt, and time it with my watch.  It should be really close
to 10 seconds, 9 or 11 on my watch are not close :-).

> Both I/D-cache are enabled. So, theoretical BogoMIPS should be around
> 400.

I wouldn't use BogoMIPS for any kind of benchmark.  There have been
plenty of discussions on mailing lists (including linuxppc lists) to
indicate this abosolute number doesn't mean much.  I have many PowerPC
systems running Linux, from 8xx embedded though 7400/G4 systems.  I
certainly can't predict what this number "should" be.

Verify clocks and timers are working and run some real benchmarks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
