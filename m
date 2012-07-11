Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 369722C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 21:01:21 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/fsl: Update corenet32_smp_defconfig
Date: Wed, 11 Jul 2012 18:40:04 +0800
Message-ID: <1342003205-23378-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - Enable NAND support
 - Enable CONFIG_PCI_MSI and CONFIG_MMC_SDHCI_OF

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 91db656..e54d5f0 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -36,6 +36,7 @@ CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_FSL_LBC=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MSI=y
 # CONFIG_PCIEASPM is not set
 CONFIG_RAPIDIO=y
 CONFIG_FSL_RIO=y
@@ -76,6 +77,11 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -136,6 +142,8 @@ CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_OF=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_MPC85XX=y
-- 
1.6.4
