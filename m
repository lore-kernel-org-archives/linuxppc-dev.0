Return-Path: <jdl@jdl.com>
Received: from jdl.com (www.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 851B067BB5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:53:01 +1000 (EST)
To: linuxppc-dev@ozlabs.org, khali@linux-fr.org
Subject: [PATCH 8/9 v3] Document I2C_MPC option for 86xx too.
Date: Sat, 17 Jun 2006 17:52:54 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjew-0004PG-DS@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The same I2C driver found on 85xx, etc., can be used for 86xx too.

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
