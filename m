Message-Id: <m15cofG-001SysC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: HOWTO: Creating a root file system < 32 MB
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 31 Aug 2001 09:48:54 -0400 (EDT)
In-Reply-To: <20010831131852.91AFB10CC0@denx.denx.de> from "Wolfgang Denk" at Aug 31, 2001 03:18:47 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang:

> > Objective:
> >     Create a Linux root file system that is under 32MB for a MPC8260 target.
>
> Ummm... 32 MB? That's HUGE!!! Most of the systems I see  in  products
> have root filesystems in the size of 2...8 MB.

There is one point that I didn't make clear. We are booting the board
over the wire, and we can afford the cost of 64MB DIMM instead of a 16
MB DIMM.  We have a modest amount of flash on the board 2-4MB -- This
is more than enough to hold PPCBoot.

If the board needed to be self contained, then the size of the root
file system would be much smaller.  The cost of flash is greater than
a DIMM, so it justifies the additional work in creating a 2-8 MB root
file system.

> If you want to build a lean system you have to do it the other way
> round: bottom up.

I would of taken this approach, if my goal was root filesystem that
was less 8 MB.


Open Question:

How have other people have dealt with the creation of a root file
system?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
