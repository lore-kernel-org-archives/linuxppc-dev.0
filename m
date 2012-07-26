Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 16/18] powerpc: Remove virt_to_abs() now all users have been
 fixed
Date: Thu, 26 Jul 2012 17:20:02 +1000
Message-Id: <1343287204-7700-16-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/abs_addr.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/abs_addr.h b/arch/powerpc/include/asm/abs_addr.h
index 80a9535..dc667d4 100644
--- a/arch/powerpc/include/asm/abs_addr.h
+++ b/arch/powerpc/include/asm/abs_addr.h
@@ -18,8 +18,5 @@
 #include <asm/page.h>
 #include <asm/prom.h>
 
-/* Convenience macros */
-#define virt_to_abs(va) __pa(va)
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ABS_ADDR_H */
-- 
1.7.9.5
