Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6E443B7230
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 15:20:49 +1000 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc,
	mpc5200: update mpc5200_defconfig to fit for charon board.
Date: Wed,  4 May 2011 07:20:46 +0200
Message-Id: <1304486446-20985-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add:

- CONFIG_MTD_PLATRAM=y
  (selects CONFIG_MTD_RAM, so this is removed)
- CONFIG_FIXED_PHY=y
- CONFIG_SENSORS_LM80=y
- CONFIG_FB_FOREIGN_ENDIAN=y
- CONFIG_FB_SM501=m
- CONFIG_RTC_DRV_DS1374=y

also to the mpc5200_defconfig, as Grant suggested here:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-May/089844.html

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Grant Likely <grant.likely@secretlab.ca>
cc: Wolfgang Denk <wd@denx.de>
---
based against:
git://git.secretlab.ca/git/linux-2.6

./scripts/checkpatch.pl 0002-powerpc-mpc5200-update-mpc5200_defconfig-to-fit-for-.patch
total: 0 errors, 0 warnings, 39 lines checked

0002-powerpc-mpc5200-update-mpc5200_defconfig-to-fit-for-.patch has no obvious style problems and is ready for submission.

 arch/powerpc/configs/mpc5200_defconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index e9813a7..7a0bcd7 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -41,9 +41,9 @@ CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_RAM=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_UBI=m
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -59,6 +59,7 @@ CONFIG_PATA_MPC52xx=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_LXT_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_FEC_MPC52xx=y
 # CONFIG_NETDEV_1000 is not set
@@ -77,11 +78,15 @@ CONFIG_SPI_GPIO=m
 CONFIG_SPI_MPC52xx=m
 CONFIG_SPI_MPC52xx_PSC=m
 CONFIG_SPI_SPIDEV=m
+CONFIG_SENSORS_LM80=y
 CONFIG_WATCHDOG=y
+CONFIG_MFD_SM501=m
 CONFIG_DRM=y
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
+CONFIG_FB_FOREIGN_ENDIAN=y
 CONFIG_FB_RADEON=y
+CONFIG_FB_SM501=m
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
@@ -109,6 +114,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-- 
1.7.4.4
