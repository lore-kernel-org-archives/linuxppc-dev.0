Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A3ADE67D43
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:34 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4HAUYt7023922
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:30:34 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4HAQDma020038
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:26:14 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D623@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 6/10]  Add  Tundra pci vendor and device ID
Date: Wed, 17 May 2006 18:14:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Tundra Semiconductor pci host bridge vendor ID and device ID

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

---

 include/linux/pci_ids.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

14bddf6670ca982d5cee57afa472d2199e2170fc
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d6fe048..c39fcfc 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2276,3 +2276,7 @@ #define PCI_DEVICE_ID_RME_DIGI32	0x9896
 #define PCI_DEVICE_ID_RME_DIGI32_PRO	0x9897
 #define PCI_DEVICE_ID_RME_DIGI32_8	0x9898
 
+#define PCI_VENDOR_ID_TUNDRA		0x10e3
+#define PCI_DEVICE_ID_TUNDRA_CA91C042	0x0000
+#define PCI_DEVICE_ID_TUNDRA_TSI108	0x0108
+#define PCI_DEVICE_ID_TUNDRA_TSI109	0xA108
-- 
1.3.0
