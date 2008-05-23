Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9C5FBDE0B2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:28 +1000 (EST)
Date: Fri, 23 May 2008 16:39:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/12] platinumfb: use linux/of_{device,platform}.h instead
	of asm
Message-Id: <20080523163958.c4236156.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
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
 drivers/video/platinumfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index cbe71a5..03b3670 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -31,11 +31,11 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/nvram.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pgtable.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 
 #include "macmodes.h"
 #include "platinumfb.h"
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
