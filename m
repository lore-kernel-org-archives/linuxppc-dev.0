Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5DB9DB6FB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 17:55:22 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id BE4A61C01A2A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:20 +0200 (CEST)
Received: from mail.denx.de (host-82-135-33-74.customer.m-online.net
	[82.135.33.74])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA id B97A81C000AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:20 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail.denx.de (Postfix) with ESMTP id A485134006D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:20 +0200 (CEST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc, mpc5200: add options to mpc5200_defconfig
Date: Wed, 22 Jun 2011 09:55:11 +0200
Message-Id: <1308729311-15375-5-git-send-email-hs@denx.de>
In-Reply-To: <1308729311-15375-1-git-send-email-hs@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the following options to the mpc5200_defconfig, needed
for the a4m072 board support:

CONFIG_AMD_PHY=y
CONFIG_MTD_PLATRAM=y -> this deletes CONFIG_MTD_RAM=y
CONFIG_GPIO_SYSFS=y
CONFIG_SENSORS_LM87=m
CONFIG_RTC_DRV_PCF8563=m

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Wolfgang Denk <wd@denx.de>
---
 arch/powerpc/configs/mpc5200_defconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index b3e27f6..1e64591 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -39,9 +39,9 @@ CONFIG_MTD_CHAR=y
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
@@ -56,6 +56,7 @@ CONFIG_ATA=y
 CONFIG_PATA_MPC52xx=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
+CONFIG_AMD_PHY=y
 CONFIG_LXT_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_FEC_MPC52xx=y
@@ -75,6 +76,8 @@ CONFIG_SPI_GPIO=m
 CONFIG_SPI_MPC52xx=m
 CONFIG_SPI_MPC52xx_PSC=m
 CONFIG_SPI_SPIDEV=m
+CONFIG_GPIO_SYSFS=y
+CONFIG_SENSORS_LM87=m
 CONFIG_WATCHDOG=y
 CONFIG_DRM=y
 CONFIG_VIDEO_OUTPUT_CONTROL=y
@@ -107,6 +110,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_PCF8563=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-- 
1.7.5.4
