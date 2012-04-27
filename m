Return-Path: <B36685@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6F51B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 13:17:58 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc/85xx: Enable MTD/NOR/NAND options by default in
 defconfig
Date: Fri, 27 Apr 2012 11:01:00 +0800
Message-ID: <1335495660-14898-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
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
based on master branch of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git tree.
v3: remove "CONFIG_MTD_NAND_VERIFY_WRITE=y"
v2: remove typo "CONFIG_MPC8xxx_GPIO=y"

 arch/powerpc/configs/mpc85xx_defconfig     |   24 ++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_smp_defconfig |   24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index d6b6df5..8c3da78 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -74,6 +74,30 @@ CONFIG_INET_ESP=y
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
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 5b0e292..575c410 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -76,6 +76,30 @@ CONFIG_INET_ESP=y
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
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
-- 
1.6.4
