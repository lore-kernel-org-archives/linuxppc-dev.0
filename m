Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 81CC867B66
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 04:53:35 +1000 (EST)
Date: Sun, 24 Sep 2006 20:53:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] update powerpc defconfig files after libata kconfig breakage
Message-ID: <20060924185329.GA10749@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Update defconfig files after libata .config breakage

 sed -i 's/CONFIG_SCSI_SATA_/CONFIG_SATA_/;s/CONFIG_SCSI_SATA/CONFIG_ATA/' arch/powerpc/configs/*g

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/configs/chrp32_defconfig       |    2 +-
 arch/powerpc/configs/g5_defconfig           |   28 ++++++++++++++--------------
 arch/powerpc/configs/iseries_defconfig      |    2 +-
 arch/powerpc/configs/mpc7448_hpc2_defconfig |   28 ++++++++++++++--------------
 arch/powerpc/configs/mpc834x_itx_defconfig  |   28 ++++++++++++++--------------
 arch/powerpc/configs/pmac32_defconfig       |    2 +-
 arch/powerpc/configs/ppc64_defconfig        |   28 ++++++++++++++--------------
 arch/powerpc/configs/pseries_defconfig      |    2 +-
 8 files changed, 60 insertions(+), 60 deletions(-)

Index: linux-2.6/arch/powerpc/configs/chrp32_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/chrp32_defconfig
+++ linux-2.6/arch/powerpc/configs/chrp32_defconfig
@@ -492,7 +492,7 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
Index: linux-2.6/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/g5_defconfig
+++ linux-2.6/arch/powerpc/configs/g5_defconfig
@@ -490,23 +490,23 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-CONFIG_SCSI_SATA_SVW=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
 # CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
 # CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
Index: linux-2.6/arch/powerpc/configs/iseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/iseries_defconfig
+++ linux-2.6/arch/powerpc/configs/iseries_defconfig
@@ -475,7 +475,7 @@ CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
Index: linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -413,23 +413,23 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SCSI_ATA_PIIX is not set
-CONFIG_SCSI_SATA_MV=y
-# CONFIG_SCSI_SATA_NV is not set
+CONFIG_SATA_MV=y
+# CONFIG_SATA_NV is not set
 # CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
Index: linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_itx_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -464,23 +464,23 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-# CONFIG_SCSI_SATA_SVW is not set
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
 # CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-CONFIG_SCSI_SATA_SIL=y
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_SATA_SIL=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
Index: linux-2.6/arch/powerpc/configs/pmac32_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pmac32_defconfig
+++ linux-2.6/arch/powerpc/configs/pmac32_defconfig
@@ -682,7 +682,7 @@ CONFIG_SCSI_AIC7XXX_OLD=m
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
Index: linux-2.6/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6/arch/powerpc/configs/ppc64_defconfig
@@ -520,23 +520,23 @@ CONFIG_SCSI_ISCSI_ATTRS=m
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-CONFIG_SCSI_SATA=y
-# CONFIG_SCSI_SATA_AHCI is not set
-CONFIG_SCSI_SATA_SVW=y
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+CONFIG_SATA_SVW=y
 # CONFIG_SCSI_ATA_PIIX is not set
-# CONFIG_SCSI_SATA_MV is not set
-# CONFIG_SCSI_SATA_NV is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
 # CONFIG_SCSI_PDC_ADMA is not set
 # CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_SATA_QSTOR is not set
-# CONFIG_SCSI_SATA_PROMISE is not set
-# CONFIG_SCSI_SATA_SX4 is not set
-# CONFIG_SCSI_SATA_SIL is not set
-# CONFIG_SCSI_SATA_SIL24 is not set
-# CONFIG_SCSI_SATA_SIS is not set
-# CONFIG_SCSI_SATA_ULI is not set
-# CONFIG_SCSI_SATA_VIA is not set
-# CONFIG_SCSI_SATA_VITESSE is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_EATA is not set
Index: linux-2.6/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6/arch/powerpc/configs/pseries_defconfig
@@ -506,7 +506,7 @@ CONFIG_SCSI_SAS_ATTRS=m
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
