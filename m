Date: Tue, 25 Apr 2000 12:02:48 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MultiPPC - was: memory map
In-Reply-To: <39047137.8C4ECB54@embeddededge.com>
Message-ID: <Pine.BSF.4.10.10004251105490.53791-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 24 Apr 2000, Dan Malek wrote:

> I think the [8260] implementation is pretty slick, especially when
> you look at the multiprocessor implementation.

Hold it! What multiprocessor implementation? The 8260 contains a
PPC603e CPU kernel. To my knowledge, the 603 does not support
multiprocessor setups. For that you need a 604 or larger.
Is there something different with the 8260 implementation?
Do I need to read up on the datasheet here?

The reason I ask is that I would love to run a 8260 and a 8240
in a multiprocessor setup. But only if there is dedicated hardware
to support it and a Linux kernel capable of handling it. The IBM
405gp is a nice system-on-a-chip with PCI, but I would defenitely
prefer the CPM of 8260. But the 8260 does not come with PCI and
HW DMA channels as yet. I could of cause use a separate PCI
bridge, but if I need a separate chip I would prefer too see
this chip do some useful work too. Only in this kind of setup,
I would need some way of guaranteeing that the correct CPU
issues instructions to onchip peripherials. Guess this ruins it.

BTW, has anyone looked into the possibility of implementing
IEEE-1394 FireWire on a FCC of 8260? Motorola microcode perhaps?
Probabely a no-go as USB was hardwired on the 823, but perhaps
in transparent mode and in combination with a SCC for control
of external FPGA. Food for thought.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
