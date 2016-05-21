Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk4f3HgDzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:34 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id 65so27837lfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:34 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, adam.buchbinder@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0216/1529] Fix typo
Date: Sat, 21 May 2016 14:04:24 +0200
Message-Id: <20160521120424.11181-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/include/asm/pmac_feature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
index 9256979..e08e829 100644
--- a/arch/powerpc/include/asm/pmac_feature.h
+++ b/arch/powerpc/include/asm/pmac_feature.h
@@ -210,7 +210,7 @@ static inline long pmac_call_feature(int selector, struct device_node* node,
 
 /* PMAC_FTR_SOUND_CHIP_ENABLE	(struct device_node* node, 0, int value)
  * enable/disable the sound chip, whatever it is and provided it can
- * acually be controlled
+ * actually be controlled
  */
 #define PMAC_FTR_SOUND_CHIP_ENABLE	PMAC_FTR_DEF(9)
 
-- 
2.8.2.534.g1f66975
