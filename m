Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 903DDB7083
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 20:00:13 +1100 (EST)
Received: from mail78-va3 (localhost [127.0.0.1])	by mail78-va3-R.bigfish.com
 (Postfix) with ESMTP id 7F25B1007FB	for
 <linuxppc-dev@lists.ozlabs.org>; Sat,
 17 Mar 2012 09:00:06 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.254])	by
 mail78-va3.bigfish.com (Postfix) with ESMTP id 26058C0274	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 09:00:04 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mpc85xx_defconfig:Added I2C_CHARDEV option in defconfig to
 have compiled I2C device interface
Date: Sat, 17 Mar 2012 14:30:01 +0530
Message-ID: <1331974801-15845-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index f37a2ab..28378e8 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -116,6 +116,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_QE=m
 CONFIG_NVRAM=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
 CONFIG_SPI=y
-- 
1.5.5.6
