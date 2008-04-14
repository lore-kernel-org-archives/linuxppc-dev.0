Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 735CEDDF51
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 12:08:50 +1000 (EST)
Date: Mon, 14 Apr 2008 12:08:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWEPC] replace asm/of_device.h with linux/of_device.h in
	macio.h
Message-Id: <20080414120847.b3688d4d.sfr@canb.auug.org.au>
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
 include/asm-powerpc/macio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/macio.h b/include/asm-powerpc/macio.h
index 3a6cb1a..079c06e 100644
--- a/include/asm-powerpc/macio.h
+++ b/include/asm-powerpc/macio.h
@@ -2,7 +2,7 @@
 #define __MACIO_ASIC_H__
 #ifdef __KERNEL__
 
-#include <asm/of_device.h>
+#include <linux/of_device.h>
 
 extern struct bus_type macio_bus_type;
 
-- 
1.5.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
