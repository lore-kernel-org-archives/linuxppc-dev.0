Message-ID: <0b8e01c34ba7$41fb8490$8202a8c0@pit>
Reply-To: "Peter Dennett" <pdennett@padsoft.com>
From: "Peter Dennett" <pdennett@padsoft.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: IBM PPC750L vs Motorola MPC7410
Date: Wed, 16 Jul 2003 09:33:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have some SBS CK3 boards which can mount
either a IBM PPC750L or Motorola MPC7410.
There is a architecture variant for MontaVista
(older Hard Hat - SBS "K2") for the MPC7410
and I have been running it.  I have reason to switch
to the IBM part (it is known to be radiation tolerant
for space applications).

When I use the same boot image on the PPC750L
the system hangs during the bootstrap process.
(transfers to common routine to decompress the
kernel, reports successful decompress, then no
more serial output).

I don't come from the PPC world and do not know
the lineage of these chips - in fact don't know the difference
between G3 and G4...

Is there someone on this list that can be so kind as to give
me a technical summary of the differences between the
PPC750L (G3) and Motorola MPC7410 (G4) so far as
LINUX operation.

I assume some portions of the low level setup (cache,
memory, serial port, ...) are different between the two
chips.  I can ferret out and fix it, but I would rather like
to avoid becoming a complete expert on both parts...

TIA

Peter Dennett   Office: 281 334 3800  Cell: 713 899 6100
pdennett@padsoft.com                www.padsoft.com
pdennett@boatbrains.com           www.boatbrains.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
