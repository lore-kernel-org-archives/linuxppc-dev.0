Message-ID: <3846E038.E9D990BF@netx4.com>
Date: Thu, 02 Dec 1999 16:10:16 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991202153547.27124H-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:


> Ok, the wlan PCMCIA card is working....but only after an ugly hack.

That would imply there is some kind of bus timing problem.
Let's go off-line and talk about this.  It is a tedious job
to attach a logic analyzer and look at this stuff, but from
my past I have seen some pretty weird external bus cycles
associated with TLB faults and it is the only way to see
what is really happening.

There are other interesting things we could do here, like
pin static TLB entries......

By the way, excellent work!  No more pleading ignorance as in
past messages :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
