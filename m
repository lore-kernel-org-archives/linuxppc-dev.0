Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 05634DDF89
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 06:57:31 +1000 (EST)
Date: Thu, 12 Apr 2007 13:34:55 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] powerpc: fix comment in booke_wdt
Message-ID: <20070412203455.GA2008@blade.az.mvista.com>
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

The early kernel parameter is wdt and not wdt_enable. according to
arch/powerpc/kernel/setup_32.c:149.

Signed-off-by: Dave Jiang <djiang@mvista.com>

--

 drivers/char/watchdog/booke_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
--

diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 4889022..46e04ae 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-/* If the kernel parameter wdt_enable=1, the watchdog will be enabled at boot.
+/* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
  * For E500 cpus the wdt_period sets which bit changing from 0->1 will
  * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
