Date: Mon, 25 Jun 2001 09:08:19 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: i82596 ethernet driver
Message-ID: <Pine.LNX.3.95.1010625085546.30987F-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our board has an i82596 ethernet chip sitting on the bus (interrupt 6,
port regs @ 0x10710000, control regs @ 0x10718000). I've been looking over
the existing driver code in drivers/net, and must admit that I'm getting a
bit frazzeled but how much dirty work it would take to fit the existing
driver to our board. Indeed, one person has already taken to driver and
created a seperate port of the driver for his board.

Does anyone have experience with this driver? Would I be best served to
use the existing code as a reference, modify the existing code to work
with my board, start from scratch, or abandon all hope and join a
monastery? If I would be best served to write my own driver, does anyone
have a good skeleton driver to use for an on-board controller? There are
isa and pci skeletons, but I am neither isa nor pci.

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
