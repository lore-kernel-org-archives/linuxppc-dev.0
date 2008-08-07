Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 47AACDDF45
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 10:30:44 +1000 (EST)
Date: Thu, 7 Aug 2008 10:30:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] of/powerpc: remove include of linux/of_platform.h from
	asm/of_platform.h
Message-Id: <20080807103040.34a0a015.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have removed all inclusions of asm/of_platform.h, this
compatibility include can be removed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/of_platform.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/of_platform.h b/arch/powerpc/include/asm/of_platform.h
index 18659ef..53b4650 100644
--- a/arch/powerpc/include/asm/of_platform.h
+++ b/arch/powerpc/include/asm/of_platform.h
@@ -11,9 +11,6 @@
  *
  */
 
-/* This is just here during the transition */
-#include <linux/of_platform.h>
-
 /* Platform drivers register/unregister */
 static inline int of_register_platform_driver(struct of_platform_driver *drv)
 {
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
