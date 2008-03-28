Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16D9EDE1CB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 02:51:36 +1100 (EST)
Date: Fri, 28 Mar 2008 10:51:29 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] mpc83xx: enable usb in 837x rdb and 83xx defconfigs
Message-Id: <20080328105129.1c585f1e.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/mpc837x_rdb_defconfig |   24 +++++++++++++++++++++++-
 arch/powerpc/configs/mpc83xx_defconfig     |   24 +++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc837x_rdb_defconfig b/arch/powerpc/configs/mpc837x_rdb_defconfig
index 44093a0..a633176 100644
--- a/arch/powerpc/configs/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc837x_rdb_defconfig
@@ -684,7 +684,29 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_HCD_PPC_OF=y
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 1f6cf68..029d2da 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -690,7 +690,29 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_HCD_PPC_OF=y
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-- 
1.5.4.4.481.g5075
