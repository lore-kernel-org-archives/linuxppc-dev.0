Message-ID: <38D642D1.8E6D34D8@mpifr-bonn.mpg.de>
Date: Mon, 20 Mar 2000 16:25:05 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Q: Paddington/Heathrow description?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all!

I am still trying to find the reason for the "runaway IRQ" from the CardBus
bridge in my Lombard PB.  Each time an IRQ is asserted in a CardBus card (I
tested a FireWire2Go and an Adaptec SlimSCSI1480A) it seems as if the INTA line
is not cleared for some strange reason.  As the interrupt flags in the CardBus
cards are cleared and I could not find any hint in the manual of the CardBus
Bridge (TI PCI1211), might this be a setup problem with the Paddington
controller chip, or is this a silly idea?  Unfortunately, there is no
information about this device on Apple's pages.  Anyone who knows more details
about this?

Thanks, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
