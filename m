From: Chas Williams <chas@cmf.nrl.navy.mil>
Date: Sat, 9 Sep 2000 13:57:36 -0400 (EDT)
Message-Id: <200009091757.NAA35435@borg.cmf.nrl.navy.mil>
To: linuxppc-dev@lists.linuxppc.org
Subject: 64-bit pci bus on a powermac g4
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i am writing a driver for an atm adapter and i am seeing some strange
problems.  the card is 32/64 bit.  it works fine in my 32-bit pci bus
on my umax s900, but in the g4 it oops' with a trap 300 during operation.
i understand this to be 'data access exception' or 'data storage exception'.

a couple questions:

. is the 64bit pci bus capability functional in the g4?  (i gather it
  must be since my 64bit ati rage pro for the second monitor is working fine)

. anyone else written a driver for a 64bit pci card in the g4's?

. do i need to align my dma regions to 64bits?  shouldnt the card be
  able transfer non-dma until it gets to a dma region?  i suppose this
  depends on the bridge/card controller.  the driver documentation
  is a bit lacking on this detail.  it claims that tx buffers dont
  require special alignment but if you dont use dma, of course it doesnt.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
