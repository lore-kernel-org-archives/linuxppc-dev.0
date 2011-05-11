Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id E341A10084E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:42 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <91eeba5f918c8fd59ccb419cb1ca15825f22e681.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:20 -0500
Subject: [PATCH 14/37] powerpc: remove powermac/pic.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Its unused, and of the three declarations, one is duplicated in pmac.h,
the second is static and the third is renamed and static.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/powermac/pic.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)
 delete mode 100644 arch/powerpc/platforms/powermac/pic.h

diff --git a/arch/powerpc/platforms/powermac/pic.h b/arch/powerpc/platforms/powermac/pic.h
deleted file mode 100644
index d622a83..0000000
--- a/arch/powerpc/platforms/powermac/pic.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __PPC_PLATFORMS_PMAC_PIC_H
-#define __PPC_PLATFORMS_PMAC_PIC_H
-
-#include <linux/irq.h>
-
-extern struct irq_chip pmac_pic;
-
-extern void pmac_pic_init(void);
-extern int pmac_get_irq(void);
-
-#endif /* __PPC_PLATFORMS_PMAC_PIC_H */
-- 
1.7.0.4
