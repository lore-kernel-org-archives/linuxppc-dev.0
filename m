Date: Tue, 6 Jan 2004 08:14:12 +0100
To: Marcus Barrow <mbarrow@sangate.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040106071412.GB735@iliana>
References: <20040101181145.GA27294@iliana> <1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana> <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana> <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana> <20040105164038.GA16158@iliana> <1073338730.9456.2487.camel@boat.sangate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073338730.9456.2487.camel@boat.sangate.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 05, 2004 at 04:38:50PM -0500, Marcus Barrow wrote:
>
> 	Hi Sven:
>
> 	I think there is some basic brokeness in the Discovery
> 	specific code. I've been meaning to go and look at some
> 	of the original code, to see if some stuff was left on
> 	the floor.

Mmm. What code are you speaking about here ?

> 	On our evalution boards the P2P registers are not set
> 	up. So you indeed have two PCI bus 0. The P2P register
> 	for PCI bus 1 should be initialized to identify it as
> 	bus 1, or whatever the right value is considering
> 	any more bridges found on bus 0.

Mmm, i understand that the 2.6.x pci domain will make this not
necessary. I might be wrong though.

> 	If you insert pci cards which contain bridges on them,
> 	they only work on the bus 0 slots...

bus 1 is used as an agp bus anyway, and i doubt there are many agp
graphic cards out there with pci bridges on them. When i inserted my
Appian Jeronimo 2000 in that board, it refused to powerup at all, but
then, maybe it is drawing too much power or something. After all, it has
a 3dlabs gamma and two permedia3 on it.

> 	Do you have something like ppcboot or uboot starting
> 	your system or just a kernel? If you are using a real

Well, there is a customized SmartFirmware OpenFirmware on the board. I
even have (non-free though) access to the source of it. The board is
mostly a CHRP design.

> 	boot rom, you could try initializing the p2p registers
> 	by hand, then booting...

The Firmware guy told me don't touch it though.

> 	I'm hoping to work on this in the next few days.

Ok, great.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
