Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6D467B6F70
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 10:26:40 +1100 (EST)
Received: from mail44-va3 (localhost [127.0.0.1])	by mail44-va3-R.bigfish.com
 (Postfix) with ESMTP id 63E22440229	for <linuxppc-dev@ozlabs.org>;
 Mon, 12 Dec 2011 23:26:33 +0000 (UTC)
Received: from VA3EHSMHS004.bigfish.com (unknown [10.7.14.245])	by
 mail44-va3.bigfish.com (Postfix) with ESMTP id 41A094C0089	for
 <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 23:25:49 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: re-enable the ePAPR byte channel driver in
 corenet32_smp_defconfig
Date: Mon, 12 Dec 2011 17:25:45 -0600
Message-ID: <1323732345-20839-1-git-send-email-timur@freescale.com>
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

Commit 7c4b2f09 (powerpc: Update mpc85xx/corenet 32-bit defconfigs) accidentally
disabled the ePAPR byte channel driver in the defconfig for Freescale CoreNet
platforms.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 8ff6302..ebf42ae 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -105,6 +105,7 @@ CONFIG_FSL_PQ_MDIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_LEGACY_PTYS is not set
+CONFIG_PPC_EPAPR_HV_BYTECHAN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
-- 
1.7.3.4
