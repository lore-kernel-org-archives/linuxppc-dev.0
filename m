Date: Thu, 6 Jun 2002 10:51:46 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: scsi_to_pci_dma_dir(), <linux/pci.h>
Message-ID: <20020606105146.A23275@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that scsi_to_pci_dma_dir() appears to only get
defined in include/linux/pci.h if CONFIG_PCI is _not_ set.

That doesn't seem right.

(my linuxppc_2_4_devel tree is maybe 2 weeks old)

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
