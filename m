Message-ID: <12D79BA6.1DA9F039@india.infogain.com>
Date: Tue, 01 May 2001 15:05:22 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, denny@dominetsystems.com
Subject: Re:405gp PCI
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had a similar problem regarding intel eepro100 driver on sandpoint.
but regarding the master and target abort error ..make sure it is being cleared
initially by writing the same value in pci status register as per the pci specs.
during initialization phase status register may show these error .
I was using version 1.06.
but things went fine with version 1.09r2.

have you checked that virt_to_bus translated address can go across your
pci-host bridge.i mean to say that sometime address map configuration in pcihost
bridge may cause some problem like this.

secondly ,pci -dma interface used in newer version of drivers ( pci_consistent_xx,pci_map_xxx.....) is a feature
not a requirement.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
