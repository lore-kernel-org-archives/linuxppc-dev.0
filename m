Message-ID: <3A359AF6.229DEA77@mvista.com>
Date: Mon, 11 Dec 2000 22:26:46 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <20001211114533.A2691@brixi.research.canon.com.au> <Pine.GSO.4.21.0012110920300.24199-100000@eos> <20001212133658.C1773@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Absolutely; the bus is the bottleneck.  You'll find the network throughput
> scales almost linearly with bus speed,

I've never seen that.  My 860P with 80/40 MHz is faster than the
same processor at 50/50 MHz.  I also haven't seen the big speed
improvement using the DMA changes either.  I am experimenting with
a couple of other things, such as aligning the IP data on the
incoming side (i.e. misaligning the Ethernet frame).  Just using
bigger TCP window sizes will help more than anything else.

What tests were you using?  I have a variety of little things I
have written, but mostly use a source/sink TCP application.

> .......  Also, doesn't the 8260 have
> seperate memory subsystems to help get around this?

Yes, among other things.  The 8260 runs very well and I am currently
doing lots of performance testing on some custom boards.  I haven't
seen anything really bad in the driver yet, but there will likely be
some performance enhancements coming.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
