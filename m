Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e613c8e37489239652a88cfa34741447530f2415.1231813731.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Enable PS3 options and QPACE in ppc64_defconfig
Date: Tue, 13 Jan 2009 13:30:00 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To increase the amount of code that's built for a defconfig build.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 069ae1b..d4685d1 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -211,11 +211,28 @@ CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
 # CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE is not set
 CONFIG_PPC_PASEMI_MDIO=y
-# CONFIG_PPC_PS3 is not set
+CONFIG_PPC_PS3=y
+
+#
+# PS3 Platform Options
+#
+# CONFIG_PS3_ADVANCED is not set
+CONFIG_PS3_HTAB_SIZE=20
+# CONFIG_PS3_DYNAMIC_DMA is not set
+CONFIG_PS3_VUART=y
+CONFIG_PS3_PS3AV=y
+CONFIG_PS3_SYS_MANAGER=y
+CONFIG_PS3_STORAGE=m
+CONFIG_PS3_DISK=m
+CONFIG_PS3_ROM=m
+CONFIG_PS3_FLASH=m
+CONFIG_PS3_LPM=m
 CONFIG_PPC_CELL=y
+CONFIG_PPC_CELL_COMMON=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_PPC_CELLEB=y
+CONFIG_PPC_CELL_QPACE=y
 
 #
 # Cell Broadband Engine options
@@ -981,6 +998,9 @@ CONFIG_E1000=y
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 CONFIG_SPIDER_NET=m
+CONFIG_GELIC_NET=m
+CONFIG_GELIC_WIRELESS=y
+# CONFIG_GELIC_WIRELESS_OLD_PSK_INTERFACE is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 # CONFIG_ATL1E is not set
@@ -1370,6 +1390,8 @@ CONFIG_FB_RADEON_BACKLIGHT=y
 # CONFIG_FB_PM3 is not set
 # CONFIG_FB_CARMINE is not set
 CONFIG_FB_IBM_GXT4500=y
+CONFIG_FB_PS3=m
+CONFIG_FB_PS3_DEFAULT_SIZE_M=9
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FB_METRONOME is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
@@ -1492,6 +1514,8 @@ CONFIG_SND_PCI=y
 CONFIG_SND_PPC=y
 CONFIG_SND_POWERMAC=m
 CONFIG_SND_POWERMAC_AUTO_DRC=y
+CONFIG_SND_PS3=m
+CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
 CONFIG_SND_AOA=m
 CONFIG_SND_AOA_FABRIC_LAYOUT=m
 CONFIG_SND_AOA_ONYX=m
-- 
1.5.3.7.1.g4e596e
