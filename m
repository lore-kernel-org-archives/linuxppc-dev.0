Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2045DEB36
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:03:16 +1000 (EST)
Date: Tue, 15 Apr 2008 11:03:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] mpc8313erdb: Update defconfig, enabling FCM NAND and OF
	partitions
Message-ID: <20080415160338.GA2705@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc8313_rdb_defconfig |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/mpc8313_rdb_defconfig b/arch/powerpc/configs/mpc8313_rdb_defconfig
index 7a862a6..7d18440 100644
--- a/arch/powerpc/configs/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/mpc8313_rdb_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:14 2008
+# Fri Apr 11 11:10:09 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -196,6 +196,7 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
 # CONFIG_IOMMU_HELPER is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
@@ -360,7 +361,7 @@ CONFIG_MTD=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
-# CONFIG_MTD_OF_PARTS is not set
+CONFIG_MTD_OF_PARTS=y
 
 #
 # User Modules And Translation Layers
@@ -436,7 +437,7 @@ CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ALAUDA is not set
-# CONFIG_MTD_NAND_FSL_ELBC is not set
+CONFIG_MTD_NAND_FSL_ELBC=y
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -1293,6 +1294,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
-- 
1.5.4.4
