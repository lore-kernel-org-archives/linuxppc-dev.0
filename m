Return-Path: <prabhakar@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59F6A2C0301
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 16:46:03 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2][v4] powerpc/config: Enable memory driver
Date: Fri, 17 Jan 2014 11:15:44 +0530
Message-ID: <1389937544-29597-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Prabhakar Kushwaha <prabhakar@freescale.com>
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
 Changes for v2: Sending as it is
 Changes for v3: Sending as it is
 Changes for v4: Rebased to 
	git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git


 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/mpc85xx_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 60027c2..b717e5d 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -144,6 +144,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
+CONFIG_MEMORY=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_EXT2_FS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 6c8b020..efbe5a3 100644
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
index 5a58882..e215d4d 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -210,6 +210,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_MEMORY=y
 # CONFIG_NET_DMA is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 165e6b3..7bc167c 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -210,6 +210,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_MEMORY=y
 # CONFIG_NET_DMA is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5
