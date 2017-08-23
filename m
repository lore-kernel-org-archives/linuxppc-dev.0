Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn44JKTzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/46] powerpc/configs: Update for CONFIG_FIXED_PHY being
 selected by CONFIG_OF_MDIO
Date: Wed, 23 Aug 2017 15:37:27 +1000
Message-Id: <1503466686-10932-8-git-send-email-mpe@ellerman.id.au>
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

In commit a5e4bd991362 ("of_mdio: select fixed phy support
unconditionally"), CONFIG_OF_MDIO began selecting CONFIG_FIXED_PHY.

That means we no longer need to set it some of our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/52xx/tqm5200_defconfig     | 1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig | 1 -
 arch/powerpc/configs/mgcoge_defconfig           | 1 -
 arch/powerpc/configs/mpc512x_defconfig          | 1 -
 arch/powerpc/configs/mpc5200_defconfig          | 1 -
 arch/powerpc/configs/mpc83xx_defconfig          | 1 -
 arch/powerpc/configs/mpc866_ads_defconfig       | 1 -
 arch/powerpc/configs/tqm8xx_defconfig           | 1 -
 10 files changed, 10 deletions(-)

diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 47f458f40657..0777e6efd22d 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -48,7 +48,6 @@ CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_FEC_MPC52xx=y
 CONFIG_LXT_PHY=y
-CONFIG_FIXED_PHY=y
 CONFIG_SERIAL_MPC52xx=y
 CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index b68d80e6af95..45e7146e2ea3 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -48,7 +48,6 @@ CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
 CONFIG_CICADA_PHY=y
-CONFIG_FIXED_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 294eeba5b01d..37f4d93b3f81 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -49,7 +49,6 @@ CONFIG_MD_RAID1=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_CICADA_PHY=y
-CONFIG_FIXED_PHY=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index 4faf753b5b9a..2ebc6c6bf888 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -42,7 +42,6 @@ CONFIG_MD_RAID456=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
-CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 64628f794589..5d5f08e5b8d9 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -46,7 +46,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
 CONFIG_FS_ENET=y
 CONFIG_FS_ENET_MDIO_FCC=y
-CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 731c5ab16d47..10be5773ad5d 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -76,7 +76,6 @@ CONFIG_REALTEK_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_STE10XP=y
 CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_SERIAL_MPC52xx=y
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index e4543aa21f60..faa3d5789db8 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -50,7 +50,6 @@ CONFIG_NETDEVICES=y
 CONFIG_FEC_MPC52xx=y
 CONFIG_AMD_PHY=y
 CONFIG_LXT_PHY=y
-CONFIG_FIXED_PHY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 52d83b35de43..661e398950ee 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -63,7 +63,6 @@ CONFIG_DAVICOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index fc73cce353ec..f1f176c29fa3 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -29,7 +29,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_NETDEVICES=y
 CONFIG_FS_ENET=y
-CONFIG_FIXED_PHY=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_CPM=y
diff --git a/arch/powerpc/configs/tqm8xx_defconfig b/arch/powerpc/configs/tqm8xx_defconfig
index 0397b9f3c384..cd72193fac0a 100644
--- a/arch/powerpc/configs/tqm8xx_defconfig
+++ b/arch/powerpc/configs/tqm8xx_defconfig
@@ -45,7 +45,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_NETDEVICES=y
 CONFIG_FS_ENET=y
 CONFIG_DAVICOM_PHY=y
-CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
-- 
2.7.4
