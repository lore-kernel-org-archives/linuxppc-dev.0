Message-ID: <38554B1B.2D3C2BF2@netx4.com>
Date: Mon, 13 Dec 1999 14:38:03 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Paul Austin <Paul.Austin@madge.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM 40x and no L2 cache
References: <531CE033A25BD3119E610000F6AF15FB04FF1E@wsexch02.dev.madge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Austin wrote:


> We're currently debating whether to use x86 or PPC. There are lots of
> reasons for wanting to use an IBM 40x for our board. Unfortunately, however,
> the 40x can't support an L2 cache.


The comments about the L2 cache are usually directed to high
performance workstations using 7xx PowerPCs.

If you can't see the value in the features provided by the
embedded PowerPC over any x86, you are completely missing
the boat.  If you are doing any type of data communication
protocols, the 8xx or 8260 will perform tasks thought impossible
even on high end PCI workstations due to their specialized
communciation processor and external interfaces.  The 8260 has
local memory features much more important than any L2 cache in
an embedded environment.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
