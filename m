Message-ID: <001d01c39133$20f088a0$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Walnut PCI bridge can't be detected
Date: Mon, 13 Oct 2003 10:38:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    Concerning my pervious posts about the problem on receiving interrupt
from PCI cards. I guess it is the problem of PCI bridge..(at least I think
it is related). Watching the old post in this list, someone post the boot
log of Walnut board here long time ago. The boot log contians a line to
detect PCI bridge just after the line"PCI: Probing PCI hardware". However,
the current devel tree running on Walnut doesn't have this.

    Also, under /proc/bus/pci and /proc/pci, I can't see any information
about the brdige.

    Moreover, I find that there is a minor different on a bit in my ES1371
card on Walnut from that on PC. On PC, ES1371 seems will capture an "Slave
interrupt controller" event just after bootup. But on Walnut, the event will
become "Slave DMA controller".

    I think these all differents are rooted from some miss configuration
about PCI in u-boot or kernel early  initialization. I am not familiar with
PCI. Hope someone here knows what is happening and gives me some idea on how
to fix that.

    Thanks so much.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
