Message-Id: <l03130301b7ac8c47bb3c@[192.168.1.2]>
In-Reply-To: <v01530500b7aa4cb483fb@[199.170.89.98]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 24 Aug 2001 18:59:53 -0400
To: trag@io.com (Jeff Walther)
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Hacking the Apple x500, x600 ROMs
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:15 AM -0400 8/23/01, Jeff Walther wrote:

>Also interesting is that some PM7200 boards use the same ROMs as the x500
>machines.  The Power Computing Catalyst based clones were based on the 7200
>and had their ROMs on a DIMM.  If that DIMM is compatible with the ROM slot
>in the x500 machines, it may be possible to install modified ROM chips on
>one of the Power Computing DIMMs and then install the ROM DIMM in the ROM
>slot of the target x500/x600 machine.  One would still need to solder the
>chips to the DIMM, but one would avoid soldering on the actual motherboard.

That would be neat for Catalyst board owners. Particularly PowerCenter
folks since the new DIMM could do the "PCI Timing Update" in ROM and also
identify the PowerCenter differently from the 7200.

It would also be nice to have a real, working version of OF rather than the
half-done Apple version. Maybe an internal video driver node so that one
could boot up like those with the chaos are able to?

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
