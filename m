Date: Wed, 1 Oct 2003 17:12:47 -0400
From: Kent Borg <kentborg@borg.org>
To: "Howard, Marc" <Marc.Howard@kla-tencor.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to Put Ethernet MAC Addresses?
Message-ID: <20031001171247.I688@borg.org>
References: <2965658600EF2F41A0BEE2200DC0EE510499B0A7@ca1xpr01.kla-tencor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2965658600EF2F41A0BEE2200DC0EE510499B0A7@ca1xpr01.kla-tencor.com>; from Marc.Howard@kla-tencor.com on Wed, Oct 01, 2003 at 01:43:43PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 01, 2003 at 01:43:43PM -0700, Howard, Marc wrote:
> I also select as the first 3 bytes of the MAC address the address
> assigned to a defunct company and the lower 3 bytes derived from the
> serial number.

I kinda like that outlaw approach, it fits in with one of my pet
notions: why must ethernet hardware be issued strictly unique MAC
addresses?  It is important that a given MAC address be unique on a
single network, but once a packet hits a router, it is OK to have a
duplicate on the next network, right?  (OK, maybe the router keeps a
single ARP table for all its directly connected networks and the
collision risk is one ply larger.)  If decent random numbers are
available (as they can be with Linux), why not adopt a random MAC
address?  Notwithstanding the "birthday paradox", 48 bits (or is it
effectively 47?) is still a whopping *big* space.  Given a decently
chosen random MAC address, how big does a network of random MAC
addresses have to be for the chance of a collision to be at all
dangerous?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
