Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2BC4DE072
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 18:19:28 +1000 (EST)
Date: Tue, 19 Aug 2008 18:19:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: remove include of linux/of_device.h from
	asm/of_device.h
Message-Id: <20080819181925.cff9b5cb.sfr@canb.auug.org.au>
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

Now that we have removed all inclusions of asm/of_device.h, this
compatability include can be removed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/of_device.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

This depends on my previous patch "powerpc/drivers: use linux/of_device.h
instead of asm/of_device.h".

diff --git a/arch/powerpc/include/asm/of_device.h b/arch/powerpc/include/asm/of_device.h
index 3c12399..a64debf 100644
--- a/arch/powerpc/include/asm/of_device.h
+++ b/arch/powerpc/include/asm/of_device.h
@@ -24,8 +24,5 @@ extern struct of_device *of_device_alloc(struct device_node *np,
 extern int of_device_uevent(struct device *dev,
 			    struct kobj_uevent_env *env);
 
-/* This is just here during the transition */
-#include <linux/of_device.h>
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
