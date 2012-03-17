Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00488B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 19:59:10 +1100 (EST)
Received: from mail17-am1 (localhost [127.0.0.1])	by mail17-am1-R.bigfish.com
 (Postfix) with ESMTP id C5FAE320751	for
 <linuxppc-dev@lists.ozlabs.org>; Sat,
 17 Mar 2012 08:59:01 +0000 (UTC)
Received: from AM1EHSMHS012.bigfish.com (unknown [10.3.201.239])	by
 mail17-am1.bigfish.com (Postfix) with ESMTP id 656112A012B	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 08:58:59 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] corenet64_smp_defconfig:Added I2C_CHARDEV and I2C_MPC options
 in defconfig to have compiled I2C device interface
Date: Sat, 17 Mar 2012 14:28:56 +0530
Message-ID: <1331974736-14450-1-git-send-email-shaveta@freescale.com>
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
 arch/powerpc/configs/corenet64_smp_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 7ed8d4c..8a42ebb 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -71,6 +71,8 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MPC=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 # CONFIG_HID_SUPPORT is not set
-- 
1.5.5.6
