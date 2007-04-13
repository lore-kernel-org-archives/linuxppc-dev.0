Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 0E8BDDDE42
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 08:23:13 +1000 (EST)
Date: Fri, 13 Apr 2007 15:25:24 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org,
	galak@kernel.crashing.org
Subject: [PATCH] remove kernel module option for booke wdt
Message-ID: <20070413222524.GA24158@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove option of making booke_wdt into a kernel module. This watchdog
cannot be disabled. No point being a kernel module.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 drivers/char/watchdog/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index e812aa1..60198a7 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -548,7 +548,7 @@ config MV64X60_WDT
 	depends on WATCHDOG && MV64X60
 
 config BOOKE_WDT
-	tristate "PowerPC Book-E Watchdog Timer"
+	bool "PowerPC Book-E Watchdog Timer"
 	depends on WATCHDOG && (BOOKE || 4xx)
 	---help---
 	  Please see Documentation/watchdog/watchdog-api.txt for
