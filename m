Return-Path: <B36685@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E2B5B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2012 20:50:55 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Enable MTD/NOR/NAND options by default in
 defconfig
Date: Thu, 26 Apr 2012 18:34:03 +0800
Message-ID: <1335436443-20889-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mtd@lists.infradead.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable MTD/NOR/NAND options by default in mpc85xx_defconfig and
mpc85xx_smp_defconfig to support NOR, NAND flash.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
based on master branch of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

 arch/powerpc/configs/mpc85xx_defconfig     |   26 ++++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_smp_defconfig |   25 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index d6b6df5..a42304d 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -39,6 +39,7 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
+CONFIG_MPC8xxx_GPIO=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -74,6 +75,31 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_FTL=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 5b0e292..31ef74f 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -76,6 +76,31 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_FTL=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
-- 
1.7.0.4
