Date: Fri, 24 Mar 2000 09:55:25 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: cl.en@gmx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: different h/w addresses on one eth
In-Reply-To: <38DA8B2D.ED7A1919@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10003240951460.17333-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Mar 23 19:57:53 arma kernel: eth0: DC21041 at 0x0400 (PCI bus 0, device 14), h/w address 00:05:02:26:3a:02,
>
> > Mar 23 20:03:27 arma kernel: eth0: Digital DC21041 Tulip rev 33 at 0x400, 00:A0:40:64:5C:40, IRQ 28.
>
> > got someone of this list a solution for different h/w addresses on one eth card?
>
> You may have noticed that you get the second address from the first by
> bitswapping each byte. One of your drivers is reading backwards.

The first address was from the PCI BIOS - assuming the BIOS knows about
endianess problems with the card, the driver would be to blame. Does
anyone know what the correct prefix for this brands of card is?

Please note that the PCI being correct is only a weak assumption. Apple
has a history of storing the MAC address backwards in the PROM so you have
to byteswap - one particular case even required byteswapping nybbles :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
