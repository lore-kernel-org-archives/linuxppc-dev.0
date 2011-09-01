Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59419B6F77
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 08:31:33 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <benh@kernel.crashing.org>, <grant.likely@secretlab.ca>,
	<linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/5200: enable audio in the defconfig
Date: Thu, 1 Sep 2011 17:31:22 -0500
Message-ID: <1314916282-13863-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Audio support for the MPC5200 exists, so enable it by default.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

There was a bug in the audio drivers related to the of_platform
changes that was never discovered because these drivers were
never compiled by default.  This patch should make sure that
never happens again.

 arch/powerpc/configs/mpc5200_defconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index e63f537..2a1320f 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -88,6 +88,18 @@ CONFIG_FB_RADEON=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_PCI is not set
+# CONFIG_SND_PPC is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_MPC5200_I2S=y
+CONFIG_SND_MPC52xx_SOC_PCM030=y
+CONFIG_SND_MPC52xx_SOC_EFIKA=y
 CONFIG_HID_DRAGONRISE=y
 CONFIG_HID_GYRATION=y
 CONFIG_HID_TWINHAN=y
-- 
1.7.3.4
