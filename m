Message-ID: <38455EFD.1E37B102@packetengines.com>
Date: Wed, 01 Dec 1999 09:46:38 -0800
From: Alan Mimms <alan@packetengines.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991130222350.23593A-100000@tristar.cc.absoval.com> <3844A2E1.64157F00@packetengines.com> <38455921.52C11DB2@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry to have implied that it is OK to code as if it won't happen on 8xx processors.
I have personally been bitten by 8xx code written by others with lots of missing
EIEIOs.  I would NEVER recommend any coding practice that left off the proper guarded
characteristic on pages or left out the necessary EIEIOs between necessarily
sequential operations and the necessary cache flushing and SYNCs before DMAs.

Upon rereading what I had written, it does appear I was suggesting this type of coding
is optional, which IT MOST POINTEDLY IS NOT.

Thanks for amplifying, Dan.

a

Dan Malek wrote:

> Alan Mimms wrote:
>
> > This issue probably is nearly moot on the nearly non-superscalar (dumb as a rock)
> > 8xx processors, but is MUCH more important (i.e., VITAL) on the 82xx processors
> > with the 603ish core and on all "real" PowerPC processors.
>
> In defense of the 8xx, it isn't as dumb as some people believe.
> It is a PPC core that performs a number of performance enhancements,
> including branch folding and speculative loads.  Not to the extent
> of a superscalar (and the 603 isn't a shining star compared to
> other PPCs, either), but they still happen and you have to be
> careful of them just like any other PPC.
>
> Designing a system using a "it doesn't happen as often" requirement
> is a very poor engineering practice.
>
>         -- Dan

--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
