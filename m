Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D57371A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 21:47:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Update defconfigs
Date: Wed, 26 Aug 2015 21:47:16 +1000
Message-Id: <1440589636-14616-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mostly uninteresting, though a few worth noting:

  CONFIG_BLK_DEV_XIP			-> CONFIG_BLK_DEV_RAM_DAX
  CONFIG_CLK_PPC_CORENET		-> CONFIG_CLK_QORIQ
  CONFIG_CRYPTO_ANSI_CPRNG		-> was default=m, not anymore
  CONFIG_EXT2_FS_XIP			-> CONFIG_FS_DAX
  CONFIG_I2O=y				-> removed
  CONFIG_KEYS_DEBUG_PROC_KEYS=y		-> removed
  CONFIG_NUMA_BALANCING_DEFAULT_ENABLED	-> now default y

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/40x/acadia_defconfig         |  1 -
 arch/powerpc/configs/40x/ep405_defconfig          |  1 -
 arch/powerpc/configs/40x/kilauea_defconfig        |  1 -
 arch/powerpc/configs/40x/makalu_defconfig         |  1 -
 arch/powerpc/configs/40x/obs600_defconfig         |  1 -
 arch/powerpc/configs/40x/virtex_defconfig         |  1 -
 arch/powerpc/configs/40x/walnut_defconfig         |  1 -
 arch/powerpc/configs/44x/akebono_defconfig        |  1 -
 arch/powerpc/configs/44x/bamboo_defconfig         |  1 -
 arch/powerpc/configs/44x/currituck_defconfig      |  1 -
 arch/powerpc/configs/44x/ebony_defconfig          |  1 -
 arch/powerpc/configs/44x/eiger_defconfig          |  4 ----
 arch/powerpc/configs/44x/icon_defconfig           |  1 -
 arch/powerpc/configs/44x/iss476-smp_defconfig     |  1 -
 arch/powerpc/configs/44x/katmai_defconfig         |  1 -
 arch/powerpc/configs/44x/rainier_defconfig        |  1 -
 arch/powerpc/configs/44x/redwood_defconfig        |  4 ----
 arch/powerpc/configs/44x/sequoia_defconfig        |  1 -
 arch/powerpc/configs/44x/taishan_defconfig        |  1 -
 arch/powerpc/configs/44x/virtex5_defconfig        |  1 -
 arch/powerpc/configs/44x/warp_defconfig           |  1 -
 arch/powerpc/configs/52xx/cm5200_defconfig        |  1 -
 arch/powerpc/configs/52xx/lite5200b_defconfig     |  1 -
 arch/powerpc/configs/52xx/motionpro_defconfig     |  1 -
 arch/powerpc/configs/52xx/tqm5200_defconfig       |  1 -
 arch/powerpc/configs/83xx/asp8347_defconfig       |  1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  1 -
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  1 -
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      |  1 -
 arch/powerpc/configs/85xx/kmp204x_defconfig       |  3 +--
 arch/powerpc/configs/85xx/ksi8560_defconfig       |  1 -
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  1 -
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  1 -
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  1 -
 arch/powerpc/configs/85xx/sbc8548_defconfig       |  1 -
 arch/powerpc/configs/85xx/socrates_defconfig      |  1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  1 -
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  1 -
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  1 -
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  1 -
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  1 -
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  1 -
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  3 +--
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  1 -
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |  1 -
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  2 --
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  1 -
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  1 -
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  2 --
 arch/powerpc/configs/amigaone_defconfig           |  1 -
 arch/powerpc/configs/c2k_defconfig                |  3 ---
 arch/powerpc/configs/cell_defconfig               |  2 --
 arch/powerpc/configs/chrp32_defconfig             |  1 -
 arch/powerpc/configs/corenet32_smp_defconfig      |  5 ++---
 arch/powerpc/configs/corenet64_smp_defconfig      |  3 +--
 arch/powerpc/configs/ep8248e_defconfig            |  1 -
 arch/powerpc/configs/g5_defconfig                 |  4 +---
 arch/powerpc/configs/linkstation_defconfig        |  1 -
 arch/powerpc/configs/maple_defconfig              |  3 +--
 arch/powerpc/configs/mgcoge_defconfig             |  1 -
 arch/powerpc/configs/mpc512x_defconfig            |  5 ++---
 arch/powerpc/configs/mpc5200_defconfig            |  1 -
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  1 -
 arch/powerpc/configs/mpc8272_ads_defconfig        |  1 -
 arch/powerpc/configs/mpc83xx_defconfig            |  1 -
 arch/powerpc/configs/mpc85xx_defconfig            |  1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig        |  1 -
 arch/powerpc/configs/mpc866_ads_defconfig         |  1 -
 arch/powerpc/configs/mpc86xx_defconfig            |  1 -
 arch/powerpc/configs/mvme5100_defconfig           |  1 -
 arch/powerpc/configs/pasemi_defconfig             |  1 -
 arch/powerpc/configs/pmac32_defconfig             |  2 --
 arch/powerpc/configs/ppc40x_defconfig             |  1 -
 arch/powerpc/configs/ppc44x_defconfig             |  1 -
 arch/powerpc/configs/ppc64_defconfig              |  8 +++-----
 arch/powerpc/configs/ppc64e_defconfig             |  3 +--
 arch/powerpc/configs/ppc6xx_defconfig             |  7 ++-----
 arch/powerpc/configs/pq2fads_defconfig            |  1 -
 arch/powerpc/configs/ps3_defconfig                |  2 --
 arch/powerpc/configs/pseries_defconfig            | 10 ++++------
 arch/powerpc/configs/wii_defconfig                |  1 -
 91 files changed, 19 insertions(+), 128 deletions(-)

diff --git a/arch/powerpc/configs/40x/acadia_defconfig b/arch/powerpc/configs/40x/acadia_defconfig
index 9110a5cb1bb7..156e78310385 100644
--- a/arch/powerpc/configs/40x/acadia_defconfig
+++ b/arch/powerpc/configs/40x/acadia_defconfig
@@ -65,4 +65,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/ep405_defconfig b/arch/powerpc/configs/40x/ep405_defconfig
index 790366652ba3..90be5d4b6e70 100644
--- a/arch/powerpc/configs/40x/ep405_defconfig
+++ b/arch/powerpc/configs/40x/ep405_defconfig
@@ -65,4 +65,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index 01bd71bac027..28ffc4e739b0 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -73,4 +73,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/makalu_defconfig b/arch/powerpc/configs/40x/makalu_defconfig
index efd51701fb4d..b237e963d8fb 100644
--- a/arch/powerpc/configs/40x/makalu_defconfig
+++ b/arch/powerpc/configs/40x/makalu_defconfig
@@ -63,4 +63,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/obs600_defconfig b/arch/powerpc/configs/40x/obs600_defconfig
index 5ded3dcdf60a..395bd49c0162 100644
--- a/arch/powerpc/configs/40x/obs600_defconfig
+++ b/arch/powerpc/configs/40x/obs600_defconfig
@@ -73,4 +73,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/configs/40x/virtex_defconfig
index bcb0c4d854db..1324c432e8ab 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -75,4 +75,3 @@ CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/walnut_defconfig b/arch/powerpc/configs/40x/walnut_defconfig
index 37c838f26e53..1c0ff53cffdb 100644
--- a/arch/powerpc/configs/40x/walnut_defconfig
+++ b/arch/powerpc/configs/40x/walnut_defconfig
@@ -58,4 +58,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index ea4ef02a0578..2a640f294660 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -137,5 +137,4 @@ CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1_PPC=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/configs/44x/bamboo_defconfig
index a046f08413fd..54c2b4fe9e5b 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -56,4 +56,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/configs/44x/currituck_defconfig
index 5aa312a158dd..8df328fb09ac 100644
--- a/arch/powerpc/configs/44x/currituck_defconfig
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -96,5 +96,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/configs/44x/ebony_defconfig
index 5909e016c37d..e7655a977770 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -60,5 +60,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 57499d25c877..b1a9fce5f337 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -43,7 +43,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SAS=y
-CONFIG_I2O=y
 CONFIG_NETDEVICES=y
 CONFIG_IBM_EMAC=y
 CONFIG_IBM_EMAC_RXB=256
@@ -90,14 +89,11 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
-CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 5d52185d8f5a..98c280a4ec58 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -96,4 +96,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 0ad3e449526e..6fbdf9d85f84 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -74,5 +74,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
index a042335971da..bcddc7517fa2 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -61,4 +61,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/configs/44x/rainier_defconfig
index 91c2aff9bd55..7ebd69c87aff 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -67,4 +67,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index 7fddf3fe275c..c4708f40ce0c 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -41,7 +41,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SAS=y
-CONFIG_I2O=y
 CONFIG_NETDEVICES=y
 CONFIG_IBM_EMAC=y
 CONFIG_IBM_EMAC_RXB=256
@@ -89,14 +88,11 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
-CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index c294369cc39f..3c252f0b7969 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -68,4 +68,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/configs/44x/taishan_defconfig
index e779228d6cd6..9f82385597c7 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -62,4 +62,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/configs/44x/virtex5_defconfig
index 53d0300b3390..51e7536a496c 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -74,4 +74,3 @@ CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index ee434375fc24..16743a50462a 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -100,4 +100,3 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 19fad0e0016e..b6f53b8cafa9 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -79,4 +79,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 5f40ba92a39a..4bc377838836 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -64,4 +64,3 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 909e185a88d1..75c581e22a2b 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -92,4 +92,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index efab8388ea92..3b2aea03763e 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -94,4 +94,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index bcdfb07921fc..b5630f54c3cb 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -73,4 +73,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index b47a41f77836..3f1e95b038a7 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -89,4 +89,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index e28c83f320c1..84c3476d4a42 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -87,4 +87,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index e84d35b848c0..26b6893a8568 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -61,4 +61,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index ae145f410590..235ffa175dad 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -80,4 +80,3 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 2a5fdcbabcdd..69ea4fa65ef1 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -87,4 +87,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index 9a2ff25a2e98..208e80750687 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -77,4 +77,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index e44edc575549..d8193694a788 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -60,4 +60,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index 94a7d85f1603..de25c189d2ab 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -66,4 +66,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 761ed8ea0729..6843447edd78 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -74,4 +74,3 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index bcf1b48cc9e6..fb7fb1cd9e32 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -60,4 +60,3 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index f0f0ebf75125..5fde45037b0c 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -88,4 +88,3 @@ CONFIG_CRC_T10DIF=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index d2e4d82de14d..bf2fd3b0d121 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -75,5 +75,4 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index b0939dd9ad6f..f005e57dd118 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -236,5 +236,4 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/configs/85xx/kmp204x_defconfig
index e94d3eb4a8c1..6af1475eb9a3 100644
--- a/arch/powerpc/configs/85xx/kmp204x_defconfig
+++ b/arch/powerpc/configs/85xx/kmp204x_defconfig
@@ -189,7 +189,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
-CONFIG_CLK_PPC_CORENET=y
+CONFIG_CLK_QORIQ=y
 CONFIG_EXT2_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
@@ -217,5 +217,4 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 3be85c5f1a2a..e19ecd7d08d0 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -60,4 +60,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index e38c373f2edf..0635733b2dff 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -49,4 +49,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index 48fc8e3a7be0..7607dca540a7 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -52,4 +52,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index ecb0c3bf8796..4506fe5438ae 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -54,4 +54,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index 72b7ccfbe2c2..a8ba265eb6f6 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -51,4 +51,3 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 0ad7bd5ee6b6..7e03bd01aea1 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -88,4 +88,3 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_FONTS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index f66d16ba8c58..8ca87d79412d 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -72,4 +72,3 @@ CONFIG_CRC_T10DIF=m
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_BDI_SWITCH=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index 4daaf2943b44..b33962a4faaa 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -58,4 +58,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index bb402b3cf786..440ec8495f88 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -60,4 +60,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 685d0fb132d6..9acf0a0aca68 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -67,4 +67,3 @@ CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 02a931d4e954..7a2eecc94339 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -60,4 +60,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index 633d5b759a36..40fc685f1320 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -60,4 +60,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 858b539d004b..b76b93c6a0b8 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -108,8 +108,8 @@ CONFIG_SENSORS_LM90=y
 CONFIG_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
-CONFIG_USB_ISP1760=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ISP1760=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_PCA955X=y
@@ -146,4 +146,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index 9792a2cb9b20..c8162b6a5bbe 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -212,5 +212,4 @@ CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_LIBCRC32C=y
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index cadc36682bb4..e2503778753f 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -210,5 +210,4 @@ CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_LIBCRC32C=y
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 2aa7d9737e43..0edc30dd1d81 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -254,7 +254,6 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
@@ -269,5 +268,4 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index e32207de2b77..79f1f0985405 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -107,4 +107,3 @@ CONFIG_FONT_8x16=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index a36e11ddaebd..952650749609 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -153,4 +153,3 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index db79bdee844b..872e2a4d4c5e 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -228,7 +228,6 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
@@ -243,4 +242,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 84f1b4140579..b56cec2ba270 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -124,5 +124,4 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 91862292cd55..53471ed938ee 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -387,13 +387,11 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=y
@@ -405,4 +403,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 9227b517560a..799b73b73849 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -150,8 +150,6 @@ CONFIG_SPIDER_NET=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_TXX9_NR_UARTS=2
-CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HVC_RTAS=y
 CONFIG_IPMI_HANDLER=m
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 253a9f200097..a2d0debe1f73 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -127,5 +127,4 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 37659937bd12..2866d4fd73ab 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -115,9 +115,9 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MPC=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_MPC=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
@@ -146,8 +146,8 @@ CONFIG_UIO=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_STAGING=y
-CONFIG_FSL_CORENET_CF=y
 CONFIG_CLK_QORIQ=y
+CONFIG_FSL_CORENET_CF=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
@@ -181,5 +181,4 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 33cd1df818ad..2f86c0402b3c 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -108,9 +108,9 @@ CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MPC=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_MPC=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
@@ -172,5 +172,4 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index 7c137041f1d6..dc44a38e809f 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -73,5 +73,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 1d9ad8500909..31aac434876e 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -220,7 +220,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
@@ -231,6 +230,7 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_FS_DAX=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
@@ -265,7 +265,6 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
@@ -280,5 +279,4 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 62ae92956d05..615226643301 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -144,4 +144,3 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index ac9666f8abf1..3e53333de89a 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -102,10 +102,10 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
 CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_TI=m
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=y
+CONFIG_FS_DAX=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -131,5 +131,4 @@ CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 666922c5b572..60ce8aeaf1fb 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -84,5 +84,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_BDI_SWITCH=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 59b85cb95259..a0d2c5aacc57 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -53,7 +53,7 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_XIP=y
+CONFIG_BLK_DEV_RAM_DAX=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
@@ -113,9 +113,9 @@ CONFIG_RTC_DRV_MPC5121=y
 CONFIG_DMADEVICES=y
 CONFIG_MPC512X_DMA=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_FS_DAX=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -127,5 +127,4 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 9fd041bfd778..73e0a44e56d4 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -132,4 +132,3 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index e2647d5bb605..617deaaf054e 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -56,4 +56,3 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 825b052176af..de15456db7cf 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -79,5 +79,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 671e220a9a98..e47e1b89ff50 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -113,5 +113,4 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 6ecf7bdbc2f9..46f0483d3627 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -247,6 +247,5 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index b6c7111ea913..2fc7bb1780a3 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -239,6 +239,5 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 321412c5dae4..11b468ad7c94 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -45,4 +45,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC32_SLICEBY4=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc86xx_defconfig b/arch/powerpc/configs/mpc86xx_defconfig
index a4572563681c..012f37caa2d5 100644
--- a/arch/powerpc/configs/mpc86xx_defconfig
+++ b/arch/powerpc/configs/mpc86xx_defconfig
@@ -159,4 +159,3 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 525a2cb500a7..b32fa6417423 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -132,4 +132,3 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 8f94782eb907..4b938cf21c9b 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -183,4 +183,3 @@ CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_BLOWFISH=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index ea8705ffcd76..5348bf5a8642 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -316,7 +316,6 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
@@ -331,4 +330,3 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index a43bf6ea10fb..4faacd872cc0 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -87,4 +87,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index bbc7f76d52c8..25074bdda345 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -110,6 +110,5 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_VIRTUALIZATION=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index a97efc2146fd..cc9d7194a4dc 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -24,9 +24,9 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PPC_SPLPAR=y
+CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
-CONFIG_DTL=y
 CONFIG_PPC_MAPLE=y
 CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
@@ -39,8 +39,8 @@ CONFIG_PPC_IBM_CELL_BLADE=y
 CONFIG_PPC_CELL_QPACE=y
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
-CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
@@ -191,7 +191,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
-CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_JSM=m
 CONFIG_HVC_CONSOLE=y
 CONFIG_HVC_RTAS=y
@@ -267,7 +266,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
@@ -286,6 +284,7 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
@@ -349,7 +348,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index ddf9773458cf..9ed9c620bc2c 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -182,7 +182,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
@@ -199,6 +198,7 @@ CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
@@ -258,5 +258,4 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index e5d2c3dc07f1..d4bc36304151 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -907,7 +907,7 @@ CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_FSL=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
@@ -1033,7 +1033,6 @@ CONFIG_EXT2_FS=m
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=m
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
@@ -1051,6 +1050,7 @@ CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_GFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
@@ -1175,7 +1175,6 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
@@ -1183,7 +1182,6 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
@@ -1211,7 +1209,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_HIFN_795X=m
 CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
 CONFIG_CRYPTO_DEV_TALITOS=m
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 3e336ee8bb4a..cd9a00cb5513 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -82,4 +82,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index adc14e813a49..40e519b9c129 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -175,9 +175,7 @@ CONFIG_DEBUG_LOCKDEP=y
 CONFIG_DEBUG_LIST=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
-CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 2404271ec4ae..f6397d8b109e 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -16,7 +16,6 @@ CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NUMA_BALANCING=y
-CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
@@ -39,9 +38,9 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PPC_SPLPAR=y
+CONFIG_DTL=y
 CONFIG_SCANLOG=m
 CONFIG_PPC_SMLPAR=y
-CONFIG_DTL=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
@@ -190,8 +189,6 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_GENERIC=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
 CONFIG_FB=y
@@ -231,13 +228,14 @@ CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
@@ -256,6 +254,7 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
+CONFIG_FS_DAX=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
@@ -314,7 +313,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 34eaf528fa87..ff8226677f25 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -122,5 +122,4 @@ CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-- 
2.1.4
