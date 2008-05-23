Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23E51DE013
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:20 +1000 (EST)
Date: Fri, 23 May 2008 16:32:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/12] of_serial: use linux/of_platform.h instead of asm
Message-Id: <20080523163254.b9c9ba9e.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/serial/of_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 25029c7..8fa0ff5 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -13,8 +13,8 @@
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/prom.h>
 
 struct of_serial_info {
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
