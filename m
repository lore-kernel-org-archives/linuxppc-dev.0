Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnK0NbGzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 32/46] powerpc/configs: Update for CONFIG_INPUT_MOUSEDEV=n
Date: Wed, 23 Aug 2017 15:37:52 +1000
Message-Id: <1503466686-10932-33-git-send-email-mpe@ellerman.id.au>
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

In commit 73d8ef76006b ("Input: mousedev - stop offering PS/2 to
userspace by default") the symbol INPUT_MOUSEDEV went from being
'default y' to 'default n' (implied).

That means we no longer need to explicitly disable it in our
defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/83xx/asp8347_defconfig     | 1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig | 1 -
 arch/powerpc/configs/83xx/sbc834x_defconfig     | 1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig     | 1 -
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig | 1 -
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig | 1 -
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig | 1 -
 arch/powerpc/configs/85xx/sbc8548_defconfig     | 1 -
 arch/powerpc/configs/85xx/tqm8540_defconfig     | 1 -
 arch/powerpc/configs/85xx/tqm8541_defconfig     | 1 -
 arch/powerpc/configs/85xx/tqm8548_defconfig     | 1 -
 arch/powerpc/configs/85xx/tqm8555_defconfig     | 1 -
 arch/powerpc/configs/85xx/tqm8560_defconfig     | 1 -
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 1 -
 arch/powerpc/configs/gamecube_defconfig         | 1 -
 arch/powerpc/configs/holly_defconfig            | 1 -
 arch/powerpc/configs/mpc7448_hpc2_defconfig     | 1 -
 arch/powerpc/configs/mpc83xx_defconfig          | 1 -
 26 files changed, 26 deletions(-)

diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index 9f4467abe3d0..dd884df32dfd 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -42,7 +42,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 45e7146e2ea3..1f69f4edf074 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -48,7 +48,6 @@ CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
 CONFIG_CICADA_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index d22cc8ee92ab..797fc3ffddee 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -47,7 +47,6 @@ CONFIG_MD_RAID1=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index 507d5af9fa99..4f914906ee4b 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -35,7 +35,6 @@ CONFIG_SCSI=y
 CONFIG_NETDEVICES=y
 CONFIG_UCC_GETH=y
 CONFIG_DAVICOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index aabd75860cfe..a484eb8401e8 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -38,7 +38,6 @@ CONFIG_NETDEVICES=y
 CONFIG_UCC_GETH=y
 CONFIG_E1000=y
 CONFIG_ICPLUS_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index 48575b3e8949..d7ce3551529d 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -35,7 +35,6 @@ CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
 CONFIG_MARVELL_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index ffcbf10b3244..92134cee3f37 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -40,7 +40,6 @@ CONFIG_SCSI=y
 CONFIG_NETDEVICES=y
 CONFIG_UCC_GETH=y
 CONFIG_MARVELL_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 141fe30737f6..97f7ea5f205f 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -38,7 +38,6 @@ CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_NETDEVICES=y
 CONFIG_UCC_GETH=y
 CONFIG_BROADCOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index f9e510c645e3..ee7510a33d06 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -36,7 +36,6 @@ CONFIG_SATA_FSL=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index 2ebc6c6bf888..8966a9af4230 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -43,7 +43,6 @@ CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index 3ec9773f4ca3..7d74699334da 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -42,7 +42,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_BROADCOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 13fcee7b8fe6..9ce6f48cfb61 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -40,7 +40,6 @@ CONFIG_FS_ENET=y
 CONFIG_FS_ENET_MDIO_FCC=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index 00ce0f9b5826..5fbc3f904046 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -31,7 +31,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index 061bf8b22636..ff981d7905c7 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -34,7 +34,6 @@ CONFIG_FS_ENET=y
 CONFIG_GIANFAR=y
 CONFIG_E1000=y
 CONFIG_DAVICOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index c9bb4be056e1..974f0706d777 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -36,7 +36,6 @@ CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E1000=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index b5807cb77b05..7e3e84a842e4 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -37,7 +37,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_BROADCOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index ca05bd051c18..98982a0e82d8 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -36,7 +36,6 @@ CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index a859bffd0579..a6e21db1dafe 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -36,7 +36,6 @@ CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index b569ce6b5993..2697e4e8a761 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -43,7 +43,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 968199ac1ac6..ca1de3979474 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -36,7 +36,6 @@ CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index ab44fadda78b..ca3b8c8ef30f 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -36,7 +36,6 @@ CONFIG_BLK_DEV_VIA82CXXX=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 185302fb5bce..6531139a8a8d 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -85,7 +85,6 @@ CONFIG_DUMMY=y
 CONFIG_GIANFAR=y
 CONFIG_E1000=y
 CONFIG_BROADCOM_PHY=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=y
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index b877a6b660a1..79bbc8238b32 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -45,7 +45,6 @@ CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_NETDEVICES=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index defa4395aa71..71d8d2430b6c 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -38,7 +38,6 @@ CONFIG_NETDEVICES=y
 CONFIG_VORTEX=y
 CONFIG_TSI108_ETH=y
 CONFIG_PHYLIB=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index 56d0af49c48c..4b14c02b437c 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -39,7 +39,6 @@ CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_TSI108_ETH=y
 CONFIG_PHYLIB=y
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index c50d97ca622b..d1b82035d35f 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -64,7 +64,6 @@ CONFIG_ICPLUS_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-- 
2.7.4
