Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9AE8B70A3
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:02:54 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: ben-linux@fluff.org
Subject: [PATCH] i2c-mpc: Add support for 64bit system
Date: Tue, 15 Mar 2011 11:02:43 -0500
Message-Id: <1300204963-15855-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org, B33228@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently i2c-mpc supports 32bit system only, this modification makes it
supported on both 32-bit and 64-bit systems.  The P5020 is the first
64-bit PPC system with the i2c-mpc controller.

Based in patch from Xulei <B33228@freescale.com>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 113505a..107d5c2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -433,7 +433,7 @@ config I2C_IXP2000
 
 config I2C_MPC
 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
-	depends on PPC32
+	depends on PPC
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
-- 
1.7.2.3
