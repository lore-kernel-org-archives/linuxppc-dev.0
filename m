Message-ID: <38449F54.D6E1FC5@netx4.com>
Date: Tue, 30 Nov 1999 23:08:52 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991130222350.23593A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:


> Hmmmm.  The way ours "works for awhile", I'm wondering if there's a
> problem w/ the way the 8xx is handling the WAIT# when the MMU is enabled
> (?)

Shouldn't be the problem.  The MMU appears (on block diagrams
anyway :-) to be far enough removed from the memory controller
for this to happen.


> This is good to know.  Our card supports I/O or memory access to the
> shared memory.  We'll shift over to the I/O and try that.

The version I have running on my PowerBook only uses I/O.....
or am I mistaken?


> We've been running _lots_ of experiments with the timing settings.  So far
> 3,10,6 seems to work best....but it still fails.

Thanks.  I'll keep those numbers around.....there are others
I would rather see.....:-).


> I've seen the 'guarded' thing around in the sources, but I'm not sure what
> it's all about.  Guess I should look. ;-)

I just fixed it.  I'll send it to you privately as well as
post it on the ppc.kernel.org server.  I hope it corrects
something.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
