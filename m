Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8A3AB67C5F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:09:13 +1000 (EST)
Subject: [PATCH 10/10 v2] Document I2C_MPC option for 86xx too.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, khali@linux-fr.org
Content-Type: text/plain
Message-Id: <1149804296.23938.298.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 17:04:56 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---
 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d6d4494..fbeae82 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -252,12 +252,12 @@ config I2C_POWERMAC
 	  will be called i2c-powermac.
 
 config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx"
+	tristate "MPC107/824x/85xx/52xx/86xx"
 	depends on I2C && PPC32
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx family processors. The driver may also work on 52xx
+	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
 	  family processors, though interrupts are known not to work.
 
 	  This driver can also be built as a module.  If so, the module
