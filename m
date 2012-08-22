Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Remove unnecessary ifdefs
Date: Wed, 22 Aug 2012 17:22:22 +1000
Message-Id: <1345620143-17289-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1345620143-17289-1-git-send-email-mikey@neuling.org>
References: <1345620143-17289-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 50d82c8..b3c083d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -553,9 +553,7 @@ static inline int cpu_has_feature(unsigned long feature)
 		& feature);
 }
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
 #define HBP_NUM 1
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 #endif /* !__ASSEMBLY__ */
 
-- 
1.7.9.5
