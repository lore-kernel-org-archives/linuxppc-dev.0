Message-Id: <v01530505b6e45883fe5b@[199.170.89.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 20:32:06 -0600
To: linuxppc-dev@lists.linuxppc.org
From: trag@io.com (Jeff Walther)
Subject: PCI Slot Interrupt routing
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Apparently the Interrupt lines from the PCI slots are routed to the Grand
Central chip--I guess there's a VIA in there or something.  Does anyone
have a pin out for the Grand Central chip available, or know if there are
additional, unused Interrupt pins available on the Grand Central?   Or know
of another scheme for connecting interrupts from additional PCI slots.

Yes, I'm trying to graft additional Bandit chips onto the CPU bus.  The
memory space is reserved.  I suspect that Open Firmware will handle
identifying the additional bus.  If I can work out the CPU bus arbitration
lines, and the interrupt lines for the PCI slots, I'll be ready for a good
try.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
