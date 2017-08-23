Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn24Z77zDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/46] powerpc/configs: Drop unneeded CONFIG_CRYPTO_ANSI_CPRNG
Date: Wed, 23 Aug 2017 15:37:22 +1000
Message-Id: <1503466686-10932-3-git-send-email-mpe@ellerman.id.au>
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

Since commit 401e4238f35c ("crypto: rng - Make DRBG the default RNG") we no longer need to set CONFIG_CRYPTO_ANSI_CPRNG in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/40x/acadia_defconfig         | 1 -
 arch/powerpc/configs/40x/ep405_defconfig          | 1 -
 arch/powerpc/configs/40x/kilauea_defconfig        | 1 -
 arch/powerpc/configs/40x/makalu_defconfig         | 1 -
 arch/powerpc/configs/40x/obs600_defconfig         | 1 -
 arch/powerpc/configs/40x/virtex_defconfig         | 1 -
 arch/powerpc/configs/40x/walnut_defconfig         | 1 -
 arch/powerpc/configs/44x/akebono_defconfig        | 1 -
 arch/powerpc/configs/44x/bamboo_defconfig         | 1 -
 arch/powerpc/configs/44x/currituck_defconfig      | 1 -
 arch/powerpc/configs/44x/ebony_defconfig          | 1 -
 arch/powerpc/configs/44x/eiger_defconfig          | 1 -
 arch/powerpc/configs/44x/icon_defconfig           | 1 -
 arch/powerpc/configs/44x/iss476-smp_defconfig     | 1 -
 arch/powerpc/configs/44x/katmai_defconfig         | 1 -
 arch/powerpc/configs/44x/rainier_defconfig        | 1 -
 arch/powerpc/configs/44x/redwood_defconfig        | 1 -
 arch/powerpc/configs/44x/sequoia_defconfig        | 1 -
 arch/powerpc/configs/44x/taishan_defconfig        | 1 -
 arch/powerpc/configs/44x/virtex5_defconfig        | 1 -
 arch/powerpc/configs/44x/warp_defconfig           | 1 -
 arch/powerpc/configs/52xx/cm5200_defconfig        | 1 -
 arch/powerpc/configs/52xx/lite5200b_defconfig     | 1 -
 arch/powerpc/configs/52xx/motionpro_defconfig     | 1 -
 arch/powerpc/configs/52xx/tqm5200_defconfig       | 1 -
 arch/powerpc/configs/83xx/asp8347_defconfig       | 1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   | 1 -
 arch/powerpc/configs/83xx/sbc834x_defconfig       | 1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      | 1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig       | 1 -
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   | 1 -
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   | 1 -
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   | 1 -
 arch/powerpc/configs/85xx/sbc8548_defconfig       | 1 -
 arch/powerpc/configs/85xx/socrates_defconfig      | 1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8540_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8541_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8548_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8555_defconfig       | 1 -
 arch/powerpc/configs/85xx/tqm8560_defconfig       | 1 -
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   | 1 -
 arch/powerpc/configs/amigaone_defconfig           | 1 -
 arch/powerpc/configs/c2k_defconfig                | 1 -
 arch/powerpc/configs/chrp32_defconfig             | 1 -
 arch/powerpc/configs/ep8248e_defconfig            | 1 -
 arch/powerpc/configs/g5_defconfig                 | 1 -
 arch/powerpc/configs/linkstation_defconfig        | 1 -
 arch/powerpc/configs/maple_defconfig              | 1 -
 arch/powerpc/configs/mgcoge_defconfig             | 1 -
 arch/powerpc/configs/mpc512x_defconfig            | 1 -
 arch/powerpc/configs/mpc5200_defconfig            | 1 -
 arch/powerpc/configs/mpc7448_hpc2_defconfig       | 1 -
 arch/powerpc/configs/mpc8272_ads_defconfig        | 1 -
 arch/powerpc/configs/mpc83xx_defconfig            | 1 -
 arch/powerpc/configs/mpc866_ads_defconfig         | 1 -
 arch/powerpc/configs/mvme5100_defconfig           | 1 -
 arch/powerpc/configs/pasemi_defconfig             | 1 -
 arch/powerpc/configs/pmac32_defconfig             | 1 -
 arch/powerpc/configs/ppc40x_defconfig             | 1 -
 arch/powerpc/configs/ppc44x_defconfig             | 1 -
 arch/powerpc/configs/ppc64_defconfig              | 1 -
 arch/powerpc/configs/ppc64e_defconfig             | 1 -
 arch/powerpc/configs/ppc6xx_defconfig             | 1 -
 arch/powerpc/configs/pq2fads_defconfig            | 1 -
 arch/powerpc/configs/pseries_defconfig            | 1 -
 arch/powerpc/configs/wii_defconfig                | 1 -
 77 files changed, 77 deletions(-)

diff --git a/arch/powerpc/configs/40x/acadia_defconfig b/arch/powerpc/configs/40x/acadia_defconfig
index 3438ed99c088..e57344c3b0d7 100644
--- a/arch/powerpc/configs/40x/acadia_defconfig
+++ b/arch/powerpc/configs/40x/acadia_defconfig
@@ -64,4 +64,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/ep405_defconfig b/arch/powerpc/configs/40x/ep405_defconfig
index 36c44c0b560c..0f66f8a87be8 100644
--- a/arch/powerpc/configs/40x/ep405_defconfig
+++ b/arch/powerpc/configs/40x/ep405_defconfig
@@ -64,4 +64,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index ad2156c6e2fc..b5cc7426c21f 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -72,4 +72,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/makalu_defconfig b/arch/powerpc/configs/40x/makalu_defconfig
index a00f434c4d47..e0b1489b7c7b 100644
--- a/arch/powerpc/configs/40x/makalu_defconfig
+++ b/arch/powerpc/configs/40x/makalu_defconfig
@@ -62,4 +62,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/obs600_defconfig b/arch/powerpc/configs/40x/obs600_defconfig
index e500e6a12b3e..aac06d2ad01a 100644
--- a/arch/powerpc/configs/40x/obs600_defconfig
+++ b/arch/powerpc/configs/40x/obs600_defconfig
@@ -72,4 +72,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/configs/40x/virtex_defconfig
index a7f4119a0231..a2b2770eee8f 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -74,4 +74,3 @@ CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/40x/walnut_defconfig b/arch/powerpc/configs/40x/walnut_defconfig
index 567f99bd64a3..6faa03cd661c 100644
--- a/arch/powerpc/configs/40x/walnut_defconfig
+++ b/arch/powerpc/configs/40x/walnut_defconfig
@@ -57,4 +57,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index 143b2fbddb46..040876e26070 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -135,5 +135,4 @@ CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1_PPC=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/configs/44x/bamboo_defconfig
index 477d99fefd9a..6f3a6ecc81e7 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -55,4 +55,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/configs/44x/currituck_defconfig
index 3799a26de6f4..7edface641ee 100644
--- a/arch/powerpc/configs/44x/currituck_defconfig
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -94,5 +94,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/configs/44x/ebony_defconfig
index c265f54ab9e5..e2b6578993d5 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -59,5 +59,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index bb6bd6d90821..0c4f41795d56 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -98,4 +98,3 @@ CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 060f2edddb71..87bd812a57c5 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -94,4 +94,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 115a6b2be18b..a6a2621e4a73 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -72,5 +72,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
index b999048c4ae6..5d3f685a7af8 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -60,4 +60,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/configs/44x/rainier_defconfig
index b8c9ee45d0a2..7b8355a5698d 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -66,4 +66,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index a4bb048448da..209063695115 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -97,4 +97,3 @@ CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index b3792fd8111d..1e04122912f3 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -67,4 +67,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/configs/44x/taishan_defconfig
index ff6f86241418..42cc7b4ed95f 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -61,4 +61,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/configs/44x/virtex5_defconfig
index 902d4b1e6732..99cc3dc02df1 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -73,4 +73,3 @@ CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index ab932488e68b..b5c866073efd 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -97,4 +97,3 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index c1faac800806..73948e88ac82 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -77,4 +77,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 94dd48d77b74..6fc7f786c83c 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -62,4 +62,3 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index f97c3b0b8061..ae2a1f74103b 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -90,4 +90,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index b8b316b884aa..47f458f40657 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -92,4 +92,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index b60cac088a7b..9f4467abe3d0 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -71,4 +71,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 80aa844c1428..b68d80e6af95 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -87,4 +87,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index d89d13bc6901..d22cc8ee92ab 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -85,4 +85,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index 567c32769021..507d5af9fa99 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -59,4 +59,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index 5b8c5514a7d6..aabd75860cfe 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -78,4 +78,3 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 00f636e95cc8..294eeba5b01d 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -84,4 +84,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index a539d44d1dba..7adb6708a761 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -75,4 +75,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index 9f0ddc830c82..48575b3e8949 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -58,4 +58,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index 8eb885d99312..ffcbf10b3244 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -64,4 +64,3 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index e15670bc1711..a5986208248b 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -72,4 +72,3 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index f72e9fd9b042..f9e510c645e3 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -58,4 +58,3 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index bfff262bdc7f..4faf753b5b9a 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -86,4 +86,3 @@ CONFIG_CRC_T10DIF=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index a349e140cca1..3ec9773f4ca3 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -72,5 +72,4 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index efb5b64fb179..dd98f43b2fb8 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -233,5 +233,4 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 7c3dfbbe690c..13fcee7b8fe6 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -57,4 +57,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index fec0e7432fe3..00ce0f9b5826 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -47,4 +47,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index dae1cbeee3ef..061bf8b22636 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -50,4 +50,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index 34b33d7da2aa..c9bb4be056e1 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -52,4 +52,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index cfc254813087..b5807cb77b05 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -50,4 +50,3 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 13579cb30539..46b479001805 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -86,4 +86,3 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_FONTS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index 384926f3ce1d..9edba010d1bc 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -68,4 +68,3 @@ CONFIG_CRC_T10DIF=m
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_BDI_SWITCH=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index a6e65612c0fc..ca05bd051c18 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -56,4 +56,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index c22a4ebe6164..a859bffd0579 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -58,4 +58,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 42f5d0a7698e..b569ce6b5993 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -66,4 +66,3 @@ CONFIG_ROOT_NFS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index d2ceca178b79..968199ac1ac6 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -58,4 +58,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index 8c0ffc1df8a9..ab44fadda78b 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -58,4 +58,3 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index f1c4d79a7889..c096c9a07da7 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -143,4 +143,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 8d3e3c41258d..abd0a8dc9507 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -120,5 +120,4 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 7c9d95370150..8c954a7b2e5b 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -402,4 +402,3 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index 664f092e5867..a203b1cf67d3 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -124,5 +124,4 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index 3403b85f9d81..2e6c8a45ae88 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -70,5 +70,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index b7245851f9ac..cda8afa485a5 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -276,5 +276,4 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index b413c19d7031..5c78ee9f5d6a 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -142,4 +142,3 @@ CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index afac42d01e51..3f93d696966c 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -127,5 +127,4 @@ CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 197acaa026eb..64628f794589 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -83,5 +83,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_BDI_SWITCH=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 1a87eace0b6b..d59e1bad2ba5 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -126,5 +126,4 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 88336d0df0d6..e4543aa21f60 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -130,4 +130,3 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index d157e1364c0f..56d0af49c48c 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -54,4 +54,3 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 4cb0f617c0d6..b1e88b64536b 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -77,5 +77,4 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index d74b124e7b8c..52d83b35de43 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -111,5 +111,4 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 849ec55eb483..fc73cce353ec 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -43,4 +43,3 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC32_SLICEBY4=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 139add95a16a..b3b2775e6ae9 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -130,4 +130,3 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index fe43ff47bd2f..2168d76764e9 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -178,4 +178,3 @@ CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_BLOWFISH=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 5acfb4fcc72b..e1c88327be3b 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -325,4 +325,3 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index 4ac2de467f1a..10fb1df63b46 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -85,4 +85,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index b6bb0066f3ed..3587527921ec 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -108,6 +108,5 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_VIRTUALIZATION=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6526f508a346..73c0293b1142 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -358,7 +358,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_CRYPTO_DEV_VMX=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 52aaccd5f57b..f67e49e201fd 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -251,5 +251,4 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index c5515204660a..0bfbe29f696a 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1201,7 +1201,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_HIFN_795X=m
 CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
 CONFIG_CRYPTO_DEV_TALITOS=m
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 50b2bad51d0a..0ededa8c837d 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -79,4 +79,3 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 36593dc245bd..06b1e65e19ba 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -322,7 +322,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_CRYPTO_DEV_VMX=y
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index dcdd51b57783..5ab977c1fb1f 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -119,5 +119,4 @@ CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-- 
2.7.4
