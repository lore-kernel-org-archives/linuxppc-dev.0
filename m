Message-ID: <3A5EEB63.52F7FBDF@petig-baender.de>
Date: Fri, 12 Jan 2001 12:32:51 +0100
From: Christof Petig <christof@petig-baender.de>
MIME-Version: 1.0
To: "Halfmann, Klaus" <klaus.halfmann@feri.de>
CC: Linux PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iBook Modem via daca, was RE: iBook's daca ...
References: <B171A2EF290DD4118E510010B5029006802178@feriex.feri.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Halfmann, Klaus" wrote:

> Many thanks for the people that care about sound on the iBook.
> While you find out about the i2c interface, please find out
> how to make the modem audible, too. It must be hidden somewhere
> around there. Someone (perhaps BenH) then should decide how this
> can be incorporated into the serial driver (cobalt modem).

Of course it is related to the i2c interface (the mixer is accessed via
i2c). The code is there but mixing doesn't work at all.
What if you enable the modem speaker whithin MacOS (you might not be
able to turn it off in linux) and reboot. OF sets Mac OS's sound
settings on boot.

Christof

PS: Does anybody know whether 3D support with an ATI Mach64 within
XF4.0+ is possible at all?
I know it's not implemented yet.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
