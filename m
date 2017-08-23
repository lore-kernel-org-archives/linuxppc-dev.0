Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn21v1czDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/46] powerpc/configs: Update for symbol movement only
Date: Wed, 23 Aug 2017 15:37:21 +1000
Message-Id: <1503466686-10932-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update defconfigs for symbols that have moved around, without their
value changing.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/40x/virtex_defconfig       |  2 +-
 arch/powerpc/configs/44x/virtex5_defconfig      |  2 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig   |  2 +-
 arch/powerpc/configs/52xx/motionpro_defconfig   | 14 ++++++------
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig |  2 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig |  4 ++--
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig |  2 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig |  2 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig |  2 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig |  2 +-
 arch/powerpc/configs/83xx/sbc834x_defconfig     |  2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig    |  2 +-
 arch/powerpc/configs/85xx/ksi8560_defconfig     |  2 +-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig |  2 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig |  4 ++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig |  2 +-
 arch/powerpc/configs/85xx/sbc8548_defconfig     |  2 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig     |  2 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig     |  2 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig     |  2 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig     |  2 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig |  2 +-
 arch/powerpc/configs/adder875_defconfig         |  2 +-
 arch/powerpc/configs/cell_defconfig             |  2 +-
 arch/powerpc/configs/chrp32_defconfig           |  2 +-
 arch/powerpc/configs/ep88xc_defconfig           |  2 +-
 arch/powerpc/configs/g5_defconfig               |  6 ++---
 arch/powerpc/configs/holly_defconfig            |  2 +-
 arch/powerpc/configs/maple_defconfig            |  4 ++--
 arch/powerpc/configs/mpc512x_defconfig          | 24 ++++++++++----------
 arch/powerpc/configs/mpc7448_hpc2_defconfig     |  2 +-
 arch/powerpc/configs/mpc83xx_defconfig          |  6 ++---
 arch/powerpc/configs/mpc866_ads_defconfig       |  2 +-
 arch/powerpc/configs/mpc86xx_basic_defconfig    | 12 +++++-----
 arch/powerpc/configs/mpc885_ads_defconfig       |  2 +-
 arch/powerpc/configs/pmac32_defconfig           |  4 ++--
 arch/powerpc/configs/powernv_defconfig          |  6 ++---
 arch/powerpc/configs/ppc40x_defconfig           |  2 +-
 arch/powerpc/configs/ppc44x_defconfig           |  2 +-
 arch/powerpc/configs/ppc64_defconfig            | 24 ++++++++++----------
 arch/powerpc/configs/ppc64e_defconfig           |  6 ++---
 arch/powerpc/configs/ppc6xx_defconfig           | 24 ++++++++++----------
 arch/powerpc/configs/pseries_defconfig          | 30 ++++++++++++-------------
 arch/powerpc/configs/tqm8xx_defconfig           |  2 +-
 44 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/configs/40x/virtex_defconfig
index 65dc084a154c..a7f4119a0231 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -41,9 +41,9 @@ CONFIG_NETDEVICES=y
 CONFIG_SERIO_XILINX_XPS_PS2=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_UARTLITE=y
 CONFIG_SERIAL_UARTLITE_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_XILINX_HWICAP=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/configs/44x/virtex5_defconfig
index ce052064bcbb..902d4b1e6732 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -40,9 +40,9 @@ CONFIG_NETDEVICES=y
 CONFIG_SERIO_XILINX_XPS_PS2=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_UARTLITE=y
 CONFIG_SERIAL_UARTLITE_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_XILINX_HWICAP=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 9493b02ac660..94dd48d77b74 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -14,6 +14,7 @@ CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 CONFIG_PPC_LITE5200=y
 # CONFIG_PPC_PMAC is not set
+CONFIG_GEN_RTC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -44,7 +45,6 @@ CONFIG_SERIAL_MPC52xx=y
 CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index fe8126bc1655..f97c3b0b8061 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -41,16 +41,16 @@ CONFIG_ATA=y
 CONFIG_PATA_MPC52xx=y
 CONFIG_NETDEVICES=y
 CONFIG_FEC_MPC52xx=y
-CONFIG_MARVELL_PHY=y
+CONFIG_MDIO_BITBANG=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_CICADA_PHY=y
 CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
+CONFIG_ICPLUS_PHY=y
 CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_QSEMI_PHY=y
 CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_MDIO_BITBANG=y
+CONFIG_VITESSE_PHY=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index e789518a2881..567c32769021 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -14,7 +14,6 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC832x_MDS=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -50,6 +49,7 @@ CONFIG_I2C_MPC=y
 CONFIG_WATCHDOG=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index 917a49ca2bd1..5b8c5514a7d6 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -14,7 +14,7 @@ CONFIG_LDM_PARTITION=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC832x_RDB=y
-CONFIG_QUICC_ENGINE=y
+CONFIG_GEN_RTC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -46,7 +46,6 @@ CONFIG_ICPLUS_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
@@ -62,6 +61,7 @@ CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index ceed4c1f0ab5..8eb885d99312 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -14,7 +14,6 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC836x_MDS=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -55,6 +54,7 @@ CONFIG_I2C_MPC=y
 CONFIG_WATCHDOG=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index a6819bf3ef5e..e15670bc1711 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -12,7 +12,6 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC836x_RDK=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -63,6 +62,7 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index 4bd1992e4d98..f72e9fd9b042 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -11,6 +11,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC837x_MDS=y
+CONFIG_GEN_RTC=y
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -43,7 +44,6 @@ CONFIG_MARVELL_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index 2d4bb63882b8..bfff262bdc7f 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -11,6 +11,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_MPC837x_RDB=y
+CONFIG_GEN_RTC=y
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -51,7 +52,6 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index b3380dbd1925..a349e140cca1 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_SBC834x=y
+CONFIG_GEN_RTC=y
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -52,7 +53,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index a917f7afb4f9..efb5b64fb179 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -22,7 +22,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_GE_IMP3A=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_CPM2=y
 CONFIG_HIGHMEM=y
@@ -161,6 +160,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RX8581=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index bd814dfb0bbd..7c3dfbbe690c 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -8,6 +8,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_KSI8560=y
 CONFIG_CPM2=y
+CONFIG_GEN_RTC=y
 CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
@@ -46,7 +47,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_VT is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index 32af10def641..fec0e7432fe3 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_MPC8540_ADS=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
@@ -38,7 +39,6 @@ CONFIG_GIANFAR=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index a52b2170ee33..dae1cbeee3ef 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -7,6 +7,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_MPC8560_ADS=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
@@ -32,16 +33,15 @@ CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_GIANFAR=y
 CONFIG_E1000=y
-CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index 002bb48abaa3..34b33d7da2aa 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_MPC85xx_CDS=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
@@ -43,7 +44,6 @@ CONFIG_E1000=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index 97ae02377cf3..cfc254813087 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -6,6 +6,7 @@ CONFIG_EXPERT=y
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_SBC8548=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
@@ -44,7 +45,6 @@ CONFIG_BROADCOM_PHY=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index 908f3885f4a5..a6e65612c0fc 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_TQM8540=y
+CONFIG_GEN_RTC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -42,7 +43,6 @@ CONFIG_E100=y
 # CONFIG_VT is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index f47e57610b7c..c22a4ebe6164 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_TQM8541=y
+CONFIG_GEN_RTC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -44,7 +45,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 71552b7929cd..d2ceca178b79 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_TQM8555=y
+CONFIG_GEN_RTC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -44,7 +45,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index 25aac973d6d7..8c0ffc1df8a9 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -9,6 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
 CONFIG_TQM8560=y
+CONFIG_GEN_RTC=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
 CONFIG_NET=y
@@ -44,7 +45,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 72900b84d3e0..f1c4d79a7889 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -107,8 +107,8 @@ CONFIG_SENSORS_LM90=y
 CONFIG_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
-CONFIG_USB_ISP1760=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ISP1760=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_PCA955X=y
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs/adder875_defconfig
index 6a3f825452e9..935ea3ade7de 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -12,6 +12,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_PPC_ADDER875=y
 CONFIG_8xx_COPYBACK=y
+CONFIG_GEN_RTC=y
 CONFIG_HZ_1000=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -41,7 +42,6 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 # CONFIG_USB_SUPPORT is not set
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index aa564599e368..708a538484a6 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -34,6 +34,7 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=m
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
@@ -159,7 +160,6 @@ CONFIG_IPMI_SI=m
 CONFIG_IPMI_WATCHDOG=m
 CONFIG_IPMI_POWEROFF=m
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_WATCHDOG=y
 # CONFIG_VGA_CONSOLE is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 1f6f90cd8aff..664f092e5867 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -16,6 +16,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 # CONFIG_PPC_PMAC is not set
+CONFIG_GEN_RTC=y
 CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=y
 CONFIG_IRQ_ALL_CPUS=y
@@ -79,7 +80,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
index 95411aeeeb8d..7cb590e8f8fd 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -14,6 +14,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_PPC_EP88XC=y
 CONFIG_8xx_COPYBACK=y
+CONFIG_GEN_RTC=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -45,7 +46,6 @@ CONFIG_LXT_PHY=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index e18f2e06553f..b7245851f9ac 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_PMAC64=y
+CONFIG_GEN_RTC=y
 CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PCI_MSI=y
@@ -123,7 +124,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_AGP=m
@@ -213,20 +213,20 @@ CONFIG_USB_SERIAL_CYBERJACK=m
 CONFIG_USB_SERIAL_XIRCOM=m
 CONFIG_USB_SERIAL_OMNINET=m
 CONFIG_USB_APPLEDISPLAY=m
-CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_EXT4_FS=y
 CONFIG_REISERFS_FS=y
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_FS_DAX=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index e56e80090529..defa4395aa71 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -11,6 +11,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_EMBEDDED6xx=y
 CONFIG_PPC_HOLLY=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
@@ -49,7 +50,6 @@ CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index c4018179e219..afac42d01e51 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -24,6 +24,7 @@ CONFIG_MAC_PARTITION=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_MAPLE=y
 CONFIG_UDBG_RTAS_CONSOLE=y
+CONFIG_GEN_RTC=y
 CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PCI_MSI=y
@@ -63,7 +64,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HVC_RTAS=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
@@ -100,8 +100,8 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
 CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_TI=m
 CONFIG_EXT2_FS=y
-CONFIG_FS_DAX=y
 CONFIG_EXT4_FS=y
+CONFIG_FS_DAX=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 0b4854cf26cb..1a87eace0b6b 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -12,6 +12,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_MPC512x=y
+CONFIG_MPC512x_LPBFIFO=y
 CONFIG_MPC5121_ADS=y
 CONFIG_MPC512x_GENERIC=y
 CONFIG_PDM360NG=y
@@ -61,21 +62,21 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_NETDEVICES=y
 CONFIG_FS_ENET=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
+CONFIG_MDIO_BITBANG=y
 CONFIG_BROADCOM_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_DAVICOM_PHY=y
 CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
+CONFIG_LSI_ET1011C_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_MARVELL_PHY=y
 CONFIG_NATIONAL_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_SMSC_PHY=y
 CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
+CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
-CONFIG_MDIO_BITBANG=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
@@ -111,10 +112,9 @@ CONFIG_RTC_DRV_M41T80=y
 CONFIG_RTC_DRV_MPC5121=y
 CONFIG_DMADEVICES=y
 CONFIG_MPC512X_DMA=y
-CONFIG_MPC512x_LPBFIFO=y
-CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
+CONFIG_FS_DAX=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index d933326b4cf9..d157e1364c0f 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -11,6 +11,7 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_EMBEDDED6xx=y
 CONFIG_MPC7448HPC2=y
+CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -46,7 +47,6 @@ CONFIG_PHYLIB=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 6574477fd726..d74b124e7b8c 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -21,7 +21,6 @@ CONFIG_MPC837x_MDS=y
 CONFIG_MPC837x_RDB=y
 CONFIG_SBC834x=y
 CONFIG_ASP834x=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_MATH_EMULATION=y
 CONFIG_PCI=y
@@ -60,10 +59,10 @@ CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
 CONFIG_UCC_GETH=y
 CONFIG_GIANFAR=y
-CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
-CONFIG_VITESSE_PHY=y
 CONFIG_ICPLUS_PHY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -99,6 +98,7 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 998454471a48..849ec55eb483 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -14,6 +14,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_MPC86XADS=y
 CONFIG_8xx_COPYBACK=y
 CONFIG_8xx_CPU6=y
+CONFIG_GEN_RTC=y
 CONFIG_HZ_1000=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_SECCOMP is not set
@@ -33,7 +34,6 @@ CONFIG_FIXED_PHY=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT4_FS=y
diff --git a/arch/powerpc/configs/mpc86xx_basic_defconfig b/arch/powerpc/configs/mpc86xx_basic_defconfig
index 3283f0586e11..67bd1fa036ee 100644
--- a/arch/powerpc/configs/mpc86xx_basic_defconfig
+++ b/arch/powerpc/configs/mpc86xx_basic_defconfig
@@ -1,11 +1,11 @@
-CONFIG_HIGHMEM=y
-CONFIG_KEXEC=y
 CONFIG_PPC_86xx=y
-CONFIG_PROC_KCORE=y
+CONFIG_MPC8641_HPCN=y
+CONFIG_SBC8641D=y
+CONFIG_MPC8610_HPCD=y
 CONFIG_GEF_PPC9A=y
 CONFIG_GEF_SBC310=y
 CONFIG_GEF_SBC610=y
-CONFIG_MPC8610_HPCD=y
-CONFIG_MPC8641_HPCN=y
-CONFIG_SBC8641D=y
 CONFIG_MVME7100=y
+CONFIG_HIGHMEM=y
+CONFIG_KEXEC=y
+CONFIG_PROC_KCORE=y
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 91f53f1bec5d..ec3fcc2bf737 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -13,6 +13,7 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_8xx_COPYBACK=y
+CONFIG_GEN_RTC=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -51,7 +52,6 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
-CONFIG_GEN_RTC=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index fc1e7a7388b8..5acfb4fcc72b 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -21,6 +21,7 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_PMAC=y
 CONFIG_PPC601_SYNC_FIX=y
+CONFIG_GEN_RTC=y
 CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HIBERNATION=y
@@ -179,10 +180,10 @@ CONFIG_PPP_ASYNC=y
 CONFIG_PPP_SYNC_TTY=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_PRISM54=m
 CONFIG_B43=m
 CONFIG_B43LEGACY=m
 CONFIG_P54_COMMON=m
+CONFIG_PRISM54=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
@@ -193,7 +194,6 @@ CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_PMACZILOG=m
 CONFIG_SERIAL_PMACZILOG_TTYS=y
 CONFIG_NVRAM=y
-CONFIG_GEN_RTC=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_APM_POWER=y
 CONFIG_BATTERY_PMU=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 34fc9bbfca9e..7a798e05d1ff 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -26,8 +26,8 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_BPF=y
 CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
@@ -158,7 +158,6 @@ CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
-CONFIG_VHOST_NET=m
 CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
@@ -310,6 +309,7 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -318,7 +318,6 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SALSA20=m
-CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
@@ -329,3 +328,4 @@ CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
+CONFIG_VHOST_NET=m
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index 370c0bbcff71..4ac2de467f1a 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -51,9 +51,9 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_UARTLITE=y
 CONFIG_SERIAL_UARTLITE_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_XILINX_HWICAP=m
 CONFIG_I2C=m
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 2766e8f590bc..b6bb0066f3ed 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -68,9 +68,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_UARTLITE=y
 CONFIG_SERIAL_UARTLITE_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_XILINX_HWICAP=m
 CONFIG_I2C=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index c5246d29f385..6526f508a346 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -28,9 +28,10 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PPC_SPLPAR=y
+CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
-CONFIG_DTL=y
+CONFIG_IBMEBUS=y
 CONFIG_PPC_MAPLE=y
 CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
@@ -41,9 +42,8 @@ CONFIG_PS3_FLASH=m
 CONFIG_PS3_LPM=m
 CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_RTAS_FLASH=m
-CONFIG_IBMEBUS=y
-CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
@@ -54,11 +54,11 @@ CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_SCHED_SMT=y
-CONFIG_PCCARD=y
-CONFIG_ELECTRA_CF=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
+CONFIG_PCCARD=y
+CONFIG_ELECTRA_CF=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -154,7 +154,6 @@ CONFIG_DUMMY=m
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_VIRTIO_NET=m
-CONFIG_VHOST_NET=m
 CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
@@ -181,8 +180,8 @@ CONFIG_SUNGEM=y
 CONFIG_GELIC_NET=m
 CONFIG_GELIC_WIRELESS=y
 CONFIG_SPIDER_NET=m
-CONFIG_MARVELL_PHY=y
 CONFIG_BROADCOM_PHY=m
+CONFIG_MARVELL_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
@@ -250,6 +249,9 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=m
 CONFIG_USB_APPLEDISPLAY=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_POWERNV=m
 CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
@@ -267,7 +269,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
-CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -287,6 +288,7 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
@@ -343,6 +345,7 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -351,7 +354,6 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SALSA20=m
-CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
@@ -364,6 +366,4 @@ CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=m
-CONFIG_LEDS_POWERNV=m
+CONFIG_VHOST_NET=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 6340e6c53c54..52aaccd5f57b 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -30,8 +30,8 @@ CONFIG_BINFMT_MISC=m
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_PCI_MSI=y
-CONFIG_PCCARD=y
 CONFIG_HOTPLUG_PCI=y
+CONFIG_PCCARD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -108,8 +108,8 @@ CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_IXGB=m
 CONFIG_SUNGEM=y
-CONFIG_MARVELL_PHY=y
 CONFIG_BROADCOM_PHY=m
+CONFIG_MARVELL_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
@@ -175,7 +175,6 @@ CONFIG_INFINIBAND_ISER=m
 CONFIG_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
-CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -192,6 +191,7 @@ CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 18d0d60dadbf..c5515204660a 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -11,10 +11,10 @@ CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_CGROUPS=y
-CONFIG_CGROUP_DEVICE=y
-CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
@@ -70,7 +70,6 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_PMAC=y
 CONFIG_TAU=y
 CONFIG_TAU_AVERAGE=y
-CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_MCU_MPC8349EMITX=y
 CONFIG_HIGHMEM=y
@@ -548,16 +547,16 @@ CONFIG_PCMCIA_XIRC2PS=m
 CONFIG_FDDI=y
 CONFIG_SKFP=m
 CONFIG_NET_SB1000=m
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
 CONFIG_BROADCOM_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_DAVICOM_PHY=m
 CONFIG_ICPLUS_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_MARVELL_PHY=m
+CONFIG_QSEMI_PHY=m
 CONFIG_REALTEK_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_VITESSE_PHY=m
 CONFIG_PLIP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_FILTER=y
@@ -657,13 +656,13 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_UARTLITE=m
 CONFIG_SERIAL_PMACZILOG=m
 CONFIG_SERIAL_MPC52xx=y
 CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 CONFIG_SERIAL_JSM=m
-CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_PRINTER=m
 CONFIG_LP_CONSOLE=y
 CONFIG_PPDEV=m
@@ -1020,7 +1019,7 @@ CONFIG_UIO_CIF=m
 CONFIG_UIO_PDRV_GENIRQ=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
-CONFIG_FS_DAX=y
+CONFIG_QUICC_ENGINE=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -1042,6 +1041,7 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_GFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index fd5d98a0b95c..36593dc245bd 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -20,15 +20,15 @@ CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
 CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
 CONFIG_CGROUPS=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_SWAP=y
+CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
-CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_BPF=y
-CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_CGROUP_PERF=y
-CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
@@ -43,12 +43,12 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PPC_SPLPAR=y
+CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
-CONFIG_DTL=y
+CONFIG_IBMEBUS=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_RTAS_FLASH=m
-CONFIG_IBMEBUS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
@@ -155,7 +155,6 @@ CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
-CONFIG_VHOST_NET=m
 CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
@@ -198,8 +197,6 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_GENERIC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
 CONFIG_FB=y
@@ -227,6 +224,9 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_POWERNV=m
 CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
@@ -238,9 +238,10 @@ CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
-CONFIG_FS_DAX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -256,6 +257,7 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
@@ -307,6 +309,7 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -315,7 +318,6 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SALSA20=m
-CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
@@ -328,6 +330,4 @@ CONFIG_CRYPTO_DEV_VMX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=m
-CONFIG_LEDS_POWERNV=m
+CONFIG_VHOST_NET=m
diff --git a/arch/powerpc/configs/tqm8xx_defconfig b/arch/powerpc/configs/tqm8xx_defconfig
index 78fddf24b5d3..0397b9f3c384 100644
--- a/arch/powerpc/configs/tqm8xx_defconfig
+++ b/arch/powerpc/configs/tqm8xx_defconfig
@@ -18,6 +18,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_TQM8XX=y
 CONFIG_8xx_COPYBACK=y
 # CONFIG_8xx_CPU15 is not set
+CONFIG_GEN_RTC=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -53,7 +54,6 @@ CONFIG_FIXED_PHY=y
 CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_GEN_RTC=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
-- 
2.7.4
