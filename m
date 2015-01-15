Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B92871A0C24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 12:24:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove unused CPU_FTR_IABR
Date: Thu, 15 Jan 2015 12:24:00 +1100
Message-Id: <1421285040-30367-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We removed the last usage of CPU_FTR_IABR in commit 1ad7d70562ee
"powerpc/xmon: Enable HW instruction breakpoint on POWER8".

Mark it as free.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 22d5a7da9e68..5cf5a6d10685 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -165,7 +165,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
 #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000800000000)
-#define CPU_FTR_IABR			LONG_ASM_CONST(0x0000001000000000)
+/* Free					LONG_ASM_CONST(0x0000001000000000) */
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000008000000000)
-- 
2.1.0
