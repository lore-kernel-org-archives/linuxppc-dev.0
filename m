Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A54B2B6F86
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 02:21:58 +1000 (EST)
Received: from mail62-va3 (localhost.localdomain [127.0.0.1])	by
	mail62-va3-R.bigfish.com (Postfix) with ESMTP id 547129E82C4	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 16:21:55 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.243])	by
	mail62-va3.bigfish.com (Postfix) with ESMTP id 3A011C70260	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 16:16:54 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/86xx: enable the framebuffer console on the
	MPC8610 HPCD
Date: Thu, 23 Jun 2011 11:16:47 -0500
Message-ID: <1308845808-11392-1-git-send-email-timur@freescale.com>
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

Enable framebuffer console support by default in the defconfig on the
Freescale MPC8610 HPCD reference board.  This allows the boot messages to
be shown on the video display.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index 036bfb2..0db9ba0 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -89,6 +89,11 @@ CONFIG_I2C_MPC=y
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
+CONFIG_VGACON_SOFT_SCROLLBACK=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_MIXER_OSS=y
-- 
1.7.3.4
