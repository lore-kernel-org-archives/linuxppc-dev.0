Message-Id: <v01530504b6e45840ee6c@[199.170.89.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 20:32:04 -0600
To: linuxppc-dev@lists.linuxppc.org
From: trag@io.com (Jeff Walther)
Subject: Hammerhead pin outs:  CPU bus arbitration pins
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anybody have a pin out list or diagram for the Hammerhead memory
controller?  Specifically, I am looking for two sets of CPU-bus arbitration
pins not used by the Bandit PCI Bridges or CPU.  According to the Apple
documentation there may be two sets available, unused (or one set on the
ANS, assuming that the on-board video is a CHAOS/Control chip).

The ANS and the Power Surge machines (X500 Macs) were designed with four
Bandits in mind.  So it makes sense that the Hammerhead would have support
available for four Bandits.

I have most of a pin out for the Bandit chip in case anyone is interested.
The only pins I don't have identified are five pins that appear to handle
CPU bus arbitration (I know there are five pins, but I don't know which
does what) and two other pins, probably on the PCI side of the bridge,
which I think are PERR and SERR, but I can't be sure because they are just
tied to 5V.  Apple didn't include support for the optional signals PERR and
SERR though they are available on the Bandit.

One puzzling thing is that it seems that the ARBUS architecture should
require Master/Slave devices on the CPU bus to have six arbitration lines,
but the Bandit only has five--unless the sixth is a shared line on the bus.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
