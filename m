Subject: Cannot allocate resource region 0 of PCI bridge 0
To: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Wed, 12 Feb 2003 09:59:36 +0100
Message-ID: <OFECDAE243.D59677E8-ONC1256CCB.002F8E43@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm designing my own board around a 405GP and a 82371 Intel Southbridge
(these are the only devices on the PCI bus).
When Linux boots, I've got the following message when probing PCI :

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 0
PCI: resource is 0..ffff (100), parent c01e5678
PCI:00:01.2: Resource 4: 0000ffe0-0000ffff (f=101)

I've obtained the last 2 lines by turning on the DEBUG flag in the pci.c file.

I guess there's a conflict in the memory resource I need (probably in the PCI I/O space). How can I gather more information about this conflict?
>From where does this 0..FFFF resource come from?

Thanks for help,

Laurent

Laurent MOHIN
ACTERNA - FRANCE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
