Return-Path: <root@elitedvb.net>
Message-Id: <20070307180525.636451000@elitedvb.net>>
References: <20070307180144.812594000@elitedvb.net>>
Date: Wed, 07 Mar 2007 19:01:45 +0100
From: Felix Domke <tmbinc@elitedvb.net>
To: Linuxppc-dev@ozlabs.org
Subject: [patch 1/7] xenon: add PCI Vendor ID: Microsoft
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Felix Domke <tmbinc@elitedvb.net>

---
 include/linux/pci_ids.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.20/include/linux/pci_ids.h
===================================================================
--- linux-2.6.20.orig/include/linux/pci_ids.h	2007-03-07 19:01:12.000000000 +0100
+++ linux-2.6.20/include/linux/pci_ids.h	2007-03-07 19:01:20.000000000 +0100
@@ -2383,3 +2383,5 @@
 
 #define PCI_VENDOR_ID_QUICKNET		0x15E2
 #define PCI_DEVICE_ID_QUICKNET_XJ	0x0500
+
+#define PCI_VENDOR_ID_MICROSOFT		0x1414

--
