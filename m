Date: Thu, 24 Apr 2003 10:58:44 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux & DMA transfer (applied to 8245)
Message-ID: <3EB17B45@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,
I am implementing DMA transfers initiated by the processor for the MPC8245.
Since the standard pci_alloc_consistent take only a pci_dev structure but no
addresses, I added a configuration function to set the target address (PCI)
and the other parameters.
I can see that the DMA transfer is started, and finished (an interrupt is
generated) but I don't see the data copied on the target device ( DSP with a 4
MB memory window on PCI bus.)
My question is : What type of addreess must I give to configure the DMA
controller.
Are there also caching issues that may prevent good read/write operation
s? I suppose that the flushing og the cache done in pci_alloc_consistent is
enough.
Thanks
------------------------------------------------------------------------------
----
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
