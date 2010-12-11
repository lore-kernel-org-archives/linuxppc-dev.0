Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BCFE2B71C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 17:13:10 +1100 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc,
	mpc5200: update mpc5200_defconfig to fit for charon board.
Date: Sat, 11 Dec 2010 07:13:01 +0100
Message-Id: <1292047981-1435-2-git-send-email-hs@denx.de>
In-Reply-To: <1292047981-1435-1-git-send-email-hs@denx.de>
References: <1292047981-1435-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add to mpc5200_defconfig:

CONFIG_SENSORS_LM80=m
CONFIG_RTC_DRV_DS1374=m

as this is used by the charon board.

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Wolfram Sang <w.sang@pengutronix.de>
cc: linuxppc-dev@lists.ozlabs.org

---
- based against 2.6.37-rc4

 arch/powerpc/configs/mpc5200_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 6f75623..70e5d8e 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -78,6 +78,7 @@ CONFIG_SPI_GPIO=m
 CONFIG_SPI_MPC52xx=m
 CONFIG_SPI_MPC52xx_PSC=m
 CONFIG_SPI_SPIDEV=m
+CONFIG_SENSORS_LM80=m
 CONFIG_WATCHDOG=y
 CONFIG_DRM=y
 CONFIG_VIDEO_OUTPUT_CONTROL=y
@@ -110,6 +111,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-- 
1.7.2.3
