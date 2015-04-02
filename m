Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7E841A0B4B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 08:56:02 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59D9614009B
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2015 08:56:01 +1100 (AEDT)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/85xx: miscellaneous changes on
 mpc85xx_smp_defconfig
Date: Thu, 2 Apr 2015 16:37:52 -0500
Message-ID: <1428010674-25361-2-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
References: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge Freescale's Internal mpc85xx_smp_defconfig with upstream's.
Run savedefconfig to get the minimal change.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/configs/mpc85xx_smp_defconfig | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index b6c7111..2f67799 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -34,6 +34,7 @@ CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
 CONFIG_P1023_RDB=y
+CONFIG_TWR_P102x=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_XES_MPC85xx=y
@@ -44,6 +45,8 @@ CONFIG_TQM8548=y
 CONFIG_TQM8555=y
 CONFIG_TQM8560=y
 CONFIG_SBC8548=y
+CONFIG_PPC_QEMU_E500=y
+CONFIG_KVM_GUEST=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_HIGHMEM=y
@@ -91,13 +94,11 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -183,13 +184,9 @@ CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_DS1374=y
-CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
@@ -235,6 +232,7 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
-- 
1.9.3
