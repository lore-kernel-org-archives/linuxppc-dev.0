Return-Path: <jbaron@akamai.com>
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [23.79.238.175])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rBLYq3zFtzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 07:25:02 +1000 (AEST)
From: Jason Baron <jbaron@akamai.com>
To: akpm@linux-foundation.org
Cc: joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] powerpc: add explicit #include <asm/asm-compat.h> for
 jump label
Date: Fri, 20 May 2016 17:16:34 -0400
Message-Id: <a71251966e052e4e494957c313af02f1d9fd6ce6.1463778029.git.jbaron@akamai.com>
In-Reply-To: <cover.1463778029.git.jbaron@akamai.com>
References: <cover.1463778029.git.jbaron@akamai.com>
In-Reply-To: <cover.1463778029.git.jbaron@akamai.com>
References: <cover.1463778029.git.jbaron@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The stringify_in_c() macro may not be included. Make the dependency
explicit.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/powerpc/include/asm/jump_label.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 47e155f..9af103a 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include <asm/feature-fixups.h>
+#include <asm/asm-compat.h>
 
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
-- 
2.6.1
