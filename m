Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 94647DDFE3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:08 +1000 (EST)
Date: Fri, 23 May 2008 16:22:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 03/12] ipmi: use linux/of_{device,platform}.h instead of asm
Message-Id: <20080523162242.a040604a.sfr@canb.auug.org.au>
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
 drivers/char/ipmi/ipmi_si_intf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 1926883..f52931e 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -66,8 +66,8 @@
 #include <linux/ctype.h>
 
 #ifdef CONFIG_PPC_OF
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #endif
 
 #define PFX "ipmi_si: "
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
