Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E983EB6F8B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 08:44:45 +1000 (EST)
Received: from mail120-db3 (localhost.localdomain [127.0.0.1])	by
	mail120-db3-R.bigfish.com (Postfix) with ESMTP id BA0331000317	for
	<linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:44:41 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.242])	by
	mail120-db3.bigfish.com (Postfix) with ESMTP id 90F7942804B	for
	<linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:44:41 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v2] powerpc/85xx: enable the audio drivers in the defconfigs
Date: Tue, 16 Aug 2011 18:44:39 -0400
Message-ID: <1313534679-7523-1-git-send-email-timur@freescale.com>
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

Enable the audio drivers in the non-corenet 85xx defconfigs so that audio
is enabled on the Freescale P1022DS reference board.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index fcd85d2..a3467bf 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -139,6 +139,7 @@ CONFIG_SND=y
 CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_PPC is not set
 # CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 908c941..9693f6e 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -140,6 +140,7 @@ CONFIG_SND=y
 CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_PPC is not set
 # CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
-- 
1.7.4.4
