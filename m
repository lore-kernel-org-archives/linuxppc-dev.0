From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909102353.QAA15499@falcon.csc.calpoly.edu>
Subject: PowerMac pci kernel 2.3.16
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Date: Fri, 10 Sep 1999 16:53:00 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just out of curiousity I downloaded the 2.3.16 kernel from ftp.us.kernel.org
and tried to compile it.  I have a Kingston PCI/Ethernet card and a USB PCI
card and I found that the tulip driver for the former would not compile due to
a change in the pci_dev structure.

I then dug a little deaper to find that the pmac_pci.c file does not seem to
use this new structure when the chrp and prep pci files do.

Specifically the old structure has a "base_address" and states "use
pcibios_fixup to alter these address for platform specific issues" or something
like that.  pmac_pci.c has this pcibios_fixup where chrp and prep do not?

Is there development for the PowerMac pci bus for the 2.3 kernel?  Am I missing
something from my casual perusing of the code?

I got my 2.2.12 kernel up and running with the help of the "Various PCI
patches" thread (USB and Ethernet cards were somehow mapped wrong) and I would
hope that development does not get lost.

Thanks
Ira Weiny


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
