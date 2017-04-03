Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxPrv3XhzzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 18:09:18 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g2so28134740pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 01:09:18 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/mm: remove stale comment
Date: Mon,  3 Apr 2017 18:09:06 +1000
Message-Id: <20170403080906.26954-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code to fix the problem it describes was removed in c40785a and it
uses the stupid comment style. Away it goooooooooooooes!

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/hash_utils_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8848fec..69a05b3 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -927,11 +927,6 @@ static void __init htab_initialize(void)
 	}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-	/* On U3 based machines, we need to reserve the DART area and
-	 * _NOT_ map it to avoid cache paradoxes as it's remapped non
-	 * cacheable later on
-	 */
-
 	/* create bolted the linear mapping in the hash table */
 	for_each_memblock(memory, reg) {
 		base = (unsigned long)__va(reg->base);
-- 
2.9.3
