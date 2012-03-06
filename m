Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93462B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:03:20 +1100 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Date: Tue, 6 Mar 2012 17:05:07 +0800
Message-ID: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 include/linux/pci_ids.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 31d77af..8f026c0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -484,6 +484,7 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM_PCIE 0x0361
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
+#define PCI_DEVICE_ID_IBM_PCIX_BRIDGE	0x01a7
 
 #define PCI_SUBVENDOR_ID_IBM		0x1014
 #define PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT	0x03d4
-- 
1.6.4.1
