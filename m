Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 15/18] powerpc: Remove abs_to_virt() now all users have been
 fixed
Date: Thu, 26 Jul 2012 17:20:01 +1000
Message-Id: <1343287204-7700-15-git-send-email-michael@ellerman.id.au>
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
 arch/powerpc/include/asm/abs_addr.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/abs_addr.h b/arch/powerpc/include/asm/abs_addr.h
index 4c92fba..80a9535 100644
--- a/arch/powerpc/include/asm/abs_addr.h
+++ b/arch/powerpc/include/asm/abs_addr.h
@@ -20,7 +20,6 @@
 
 /* Convenience macros */
 #define virt_to_abs(va) __pa(va)
-#define abs_to_virt(aa) __va(aa)
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ABS_ADDR_H */
-- 
1.7.9.5
