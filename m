Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFGD6RbpzDq82
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:12:04 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id x19so8212257plr.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:12:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/9] powerpc: remove unused CPU_FTR_ARCH_201
Date: Wed, 21 Feb 2018 05:08:28 +1000
Message-Id: <20180220190832.1872-6-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 27bb8e96ce7a..1c684aa7e0de 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -175,7 +175,6 @@ static inline void cpu_feature_keys_init(void) { }
 #endif
 
 #define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000100000000)
-#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
 #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000800000000)
 #define CPU_FTR_ARCH_300		LONG_ASM_CONST(0x0000001000000000)
@@ -417,7 +416,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
 	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS | \
 	    CPU_FTR_HVMODE | CPU_FTR_DABRX)
-- 
2.16.1
