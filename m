Message-ID: <3905CC66.D68C30A4@embeddededge.com>
Date: Tue, 25 Apr 2000 12:48:38 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MultiPPC - was: memory map
References: <Pine.BSF.4.10.10004251105490.53791-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

> Hold it! What multiprocessor implementation?
> Do I need to read up on the datasheet here?

You need a little more than a datasheet......

> The reason I ask is that I would love to run a 8260 and a 8240
> in a multiprocessor setup.


Where have you been :-)?  Check out Motorola's web site and other
PowerPC board vendors.  Most use the higher performance 7xx/7xxx
with the 8260, but you could use the 8240 as well.  There are
several custom multiprocessor 8260s running for well known data/telecom
companies.

> .... But only if there is dedicated hardware
> to support it and a Linux kernel capable of handling it.

The hardware is there.  With the 8260 you have some memory/bus options
that you may want to consider as alternate performance designs.  You
may want to run two separate kernels, or you could hack something into
one Linux kernel.  I'm pretty sure you wouldn't get something off-the-
shelf today.


> .... But the 8260 does not come with PCI and
> HW DMA channels as yet. I could of cause use a separate PCI
> bridge, but if I need a separate chip I would prefer too see
> this chip do some useful work too.

Several options here too.

> ... Only in this kind of setup,
> I would need some way of guaranteeing that the correct CPU
> issues instructions to onchip peripherials. Guess this ruins it.

Huh?  Talk about giving up before you ever start.....There isn't
anything that can't be done if you want to do it.


> BTW, has anyone looked into the possibility of implementing
> IEEE-1394 FireWire on a FCC of 8260?

Yes.


> ... Motorola microcode perhaps?

Perhaps.


> Probabely a no-go as USB was hardwired on the 823,

You lost me here.........



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
