Message-ID: <38455921.52C11DB2@netx4.com>
Date: Wed, 01 Dec 1999 12:21:37 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991130222350.23593A-100000@tristar.cc.absoval.com> <3844A2E1.64157F00@packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:


> This issue probably is nearly moot on the nearly non-superscalar (dumb as a rock)
> 8xx processors, but is MUCH more important (i.e., VITAL) on the 82xx processors
> with the 603ish core and on all "real" PowerPC processors.

In defense of the 8xx, it isn't as dumb as some people believe.
It is a PPC core that performs a number of performance enhancements,
including branch folding and speculative loads.  Not to the extent
of a superscalar (and the 603 isn't a shining star compared to
other PPCs, either), but they still happen and you have to be
careful of them just like any other PPC.

Designing a system using a "it doesn't happen as often" requirement
is a very poor engineering practice.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
