Message-ID: <39D4191A.5C8DE9F0@mvista.com>
Date: Fri, 29 Sep 2000 00:22:50 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <14803.57550.118150.759977@argo.linuxcare.com.au>
		<19340823181237.25887@192.168.1.10> <14803.60860.762026.661989@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I don't see why it matters on powermacs which is the primary bridge
> though, since we fortunately don't have any legacy ISA devices.
> Hum... except for cards in the PC-card slot...  So we need to make
> sure that the bus with the cardbus controller is behind the "primary"
> bridge.

I thought this whole discussion was started because someone wanted
a 16550-like serial card on the PCI bus....

Isn't the cardbus only on the PowerBook/iBook, which only have one
PCI bus?  Of course, this will change with the new G4 PowerBooks....

> The issue here is that the pcmcia/cardbus stuff will assign a range
> of I/O addresses to a pcmcia card (starting at say I/O port n) and
> then expect that inb(n) will access the card.

That should work, and most of the modules have 'ioport=' configuration
option in any case....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
