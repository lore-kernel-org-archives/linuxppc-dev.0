Content-Type: text/plain;
  charset="iso-8859-1"
From: jim <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI and DMA
Date: Wed, 28 Aug 2002 20:58:41 +0000
MIME-Version: 1.0
Message-Id: <20020829021107.5924F38C2D@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

I've got a problem doing DMA over the PCI bus.  After I've done a DMA write
to the device, the kernel hangs when I do a pci_read_config_byte for that
device.  I've determined that when pci_read_config_byte is called, execution
makes it to the call to the read_byte function of the pci_ops structure.
(This function is pointed to by pdev->bus->ops->read_byte.)  What I can't
seem to find is the code that is actually doing the read from the device
configuration space.  Can somebody point me to it?  This is on a 405GP Walnut
board.

Thanks,
Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
