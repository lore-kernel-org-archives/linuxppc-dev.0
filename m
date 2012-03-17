Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 162E5B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 19:36:28 +1100 (EST)
Received: from mail24-tx2 (localhost [127.0.0.1])	by mail24-tx2-R.bigfish.com
 (Postfix) with ESMTP id 04C8FC0097	for
 <linuxppc-dev@lists.ozlabs.org>; Sat,
 17 Mar 2012 08:36:22 +0000 (UTC)
Received: from TX2EHSMHS024.bigfish.com (unknown [10.9.14.252])	by
 mail24-tx2.bigfish.com (Postfix) with ESMTP id 0C797480063	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 08:36:20 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <list@nmglablinux22.freescale.com>
Subject: [PATCH]corenet32_smp_defconfig:Added I2C_CHARDEV option in defconfig
 to have compiled I2C device interface
Date: Sat, 17 Mar 2012 14:06:15 +0530
Message-ID: <1331973375-21026-1-git-send-email-shaveta@freescale.com>
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
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index f8aef20..91db656 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -116,6 +116,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
-- 
1.5.5.6
