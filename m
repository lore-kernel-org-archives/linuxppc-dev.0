Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6DE5DDF5C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:25 +1000 (EST)
Subject: [PATCH v2 7/9] Add Freescale PCI VENDOR ID.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996219.9632.75.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:19 -0500
Cc: pci-ids@ucw.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also add 8641/8641D Host Bridge device IDs as well.
All of which already exist or have been submitted to
The Linux PCI ID Repository at:
    http://pci-ids.ucw.cz/

CC-to: pci-ids@ucw.cz
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 include/linux/pci_ids.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 62b3e00..0e0dc98 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2093,6 +2093,10 @@
 #define PCI_VENDOR_ID_TDI               0x192E
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
+#define PCI_VENDOR_ID_FREESCALE		0x1957
+#define PCI_DEVICE_ID_8641_PCI_HOST_BRIDGE	0x7010
+#define PCI_DEVICE_ID_8641D_PCI_HOST_BRIDGE	0x7011
+
 #define PCI_VENDOR_ID_PASEMI		0x1959
 
 #define PCI_VENDOR_ID_ATTANSIC		0x1969
-- 
1.5.0.3
