Return-Path: <prabhakar@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8212F2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 16:30:09 +1100 (EST)
Received: from mail75-va3 (localhost [127.0.0.1])	by mail75-va3-R.bigfish.com
 (Postfix) with ESMTP id B303F480208	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 28 Jan 2014 05:30:04 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][v7] powerpc/config: Enable memory driver
Date: Tue, 28 Jan 2014 10:59:56 +0530
Message-ID: <1390886996-9375-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Freescale IFC controller has been moved to driver to driver/memory.

So enable memory driver in powerpc config

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
 Branch next

 Changes for v2: Sending as it is
 Changes for v3: Sending as it is
 Changes for v4: Rebased to 
	git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 changes for v5:
 	- Rebased to branch next of 
	git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 Changes for v6: Sending as it is
 Changes for v7: Sending as it is

 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/mpc85xx_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index bbd794d..087d437 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -142,6 +142,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
+CONFIG_MEMORY=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_EXT2_FS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 63508dd..25b03f8 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -129,6 +129,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_MEMORY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 83d3550..cba638c 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -216,6 +216,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_MEMORY=y
 # CONFIG_NET_DMA is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 4b68629..e315b8a 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -217,6 +217,7 @@ CONFIG_RTC_DRV_CMOS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_MEMORY=y
 # CONFIG_NET_DMA is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5
