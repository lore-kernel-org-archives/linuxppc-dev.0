Message-ID: <392D634E.3328E9C5@embeddededge.com>
Date: Thu, 25 May 2000 13:30:54 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
CC: Neil Russell <caret@c-side.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <Pine.BSF.4.21.0005251319150.9249-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

> You tell me your HW designers can't operate a logic analyzer?

Hardware designers?  This is just software and a few wires :-).

> ...... BTW, when you
> already have a full FPGA installed then why waste a UPM?


You know, I keep hearing this question and continually find boards
with external hardware and no one using the integrated control logic.
Everyone is "saving it for something else".  Geeze, these are embedded
systems that will probably never change.  After I use up all of the
GP I/O and internal control logic, I will start looking for alternatives.
The 8260 is even better. Separate DRAM controllers so you don't even
use up the UPMs for that, more chip selects, more I/O, multiple busses.
You bought it, may as well use it.

> .... But to keep power
> drain low I will probabely use the second PCMCIA port for it
> by means of Xilinx Coolrunner and an AVR for autoconfiguration.
> Then I could (but will not) expand this into a full ISA bus.

Why bother with the Xilinx?  Just connect the IDE to the PCMCIA.
I think you could even DMA over the port.


> .... How does PPC/Linux handle this addressing
> problem?

What addressing problem?  The 860 supports 32 bits of address, so
does Linux.  No problem.  I started to add support for multiple real
memory spaces (which isn't hard, you just have to detect it), and then
realized it isn't necessary.  With the 8xx memory controller you can
make external RAM one linear space, unless you wire it up really stupid.

> One more - if anyone has the specification for Sony Memorystick
> I would be interested. I am pretty certain that this flashstick
> has a serial interface on it.

Maybe it is similar to the SanDisk MMC interface?  That is an SPI
interface, perhaps there is some access standard.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
