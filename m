From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: u64 fun and PCI DMA not working for things behind bridges?
Date: Thu, 1 Mar 2001 15:03:41 +0100
Message-Id: <19350124073525.11032@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.30.0103011305510.28644-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.30.0103011305510.28644-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I can't compile the drivers without optimization, or else i get
>> references to functions that don't exist in the kernel, for some
>> reason.
>
>What exact functions don't exist?

If you compile with -O0, you also disable inlining, which cause tons of
link errors for all inline functions. The lowest optimisation level you
can use is -O1

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
