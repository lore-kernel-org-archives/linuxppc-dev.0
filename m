Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE009.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8E2CB6FA0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 05:49:01 +1000 (EST)
Received: from mail77-ch1 (localhost.localdomain [127.0.0.1])	by
	mail77-ch1-R.bigfish.com (Postfix) with ESMTP id B4275CB024A	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 19:48:57 +0000 (UTC)
Received: from CH1EHSMHS029.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.243])	by mail77-ch1.bigfish.com (Postfix) with ESMTP id
	8DAE016F804F	for <linuxppc-dev@ozlabs.org>;
	Thu, 23 Jun 2011 19:48:57 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: enable the framebuffer console for the
	defconfigs
Date: Thu, 23 Jun 2011 14:48:55 -0500
Message-ID: <1308858535-17396-2-git-send-email-timur@freescale.com>
In-Reply-To: <1308858535-17396-1-git-send-email-timur@freescale.com>
References: <1308858535-17396-1-git-send-email-timur@freescale.com>
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

Enable framebuffer console support by default in the defconfigs for the
Freescale 85xx-based reference board.  This allows the boot messages to
be shown on the video display on the P1022DS.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     |    4 ++++
 arch/powerpc/configs/mpc85xx_smp_defconfig |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 96b89df..b212e3d 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -128,6 +128,10 @@ CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index de65841..87fbb2e 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -130,6 +130,10 @@ CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
-- 
1.7.3.4
