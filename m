Message-ID: <3A3E417E.A5B259C2@kis.uni-freiburg.de>
Date: Mon, 18 Dec 2000 17:55:30 +0100
From: Thomas Berkefeld <berke@kis.uni-freiburg.de>
Reply-To: berke@kis.uni-freiburg.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI-to-parallel port problem
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have FASTPCI 4008 PCI parallel port card from Dolphin Peripherals. To
use the card,
the manual tells to modprobe parport_pc.o with io-address and irq.
Unfortunatley
parport_pc.c cannot be compiled with
kernel 2.4.0-test11 on my G4 Mac  (a header is missing).
Furthermore /proc/pci says the interrupt number is 53 which seems a bit
high.
This is what /proc/pci says about the card:
Bus  2, device   3, function  0:
    Parallel controller: PCI device 1409:7268 (Timedia Technology Co
Ltd) (rev 1).
      IRQ 53.
      I/O at 0x1010 [0x1017].
      I/O at 0x1000 [0x1007].

Any hints?

Thanks

Thomas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
