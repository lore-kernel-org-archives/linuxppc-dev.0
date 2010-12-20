Return-Path: <B33228@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54391B6F1E
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Dec 2010 18:34:25 +1100 (EST)
From: Xulei <B33228@freescale.com>
To: <linux-i2c@vger.kernel.org>
Subject: [PATCH] I2C: Add support for 64bit system.
Date: Mon, 20 Dec 2010 15:37:34 +0800
Message-ID: <1292830654-7056-1-git-send-email-B33228@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Xulei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently I2C_MPC supports 32bit system only, then this
modification makes it support 32bit and 64bit system both.

Signed-off-by: Xulei <B33228@freescale.com>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 9c6170c..3392f4b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -422,7 +422,7 @@ config I2C_IXP2000
 
 config I2C_MPC
 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
-	depends on PPC32
+	depends on PPC32 || PPC64
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
-- 
1.7.0.4
