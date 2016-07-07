Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcyk5PnBzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:54:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] powerpc/xmon: Adjust spacing of existing SPRs to make
 room for more
Date: Thu,  7 Jul 2016 22:54:28 +1000
Message-Id: <1467896070-15167-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
References: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Purely to make it pleasing to the eye.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 369501283994..efe6f4ee4634 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1725,14 +1725,15 @@ static void super_regs(void)
 		asm("mr %0,1" : "=r" (sp) :);
 		asm("mr %0,2" : "=r" (toc) :);
 
-		printf("msr  = "REG"  sprg0= "REG"\n",
+	        printf("msr    = "REG"  sprg0 = "REG"\n",
 		       mfmsr(), mfspr(SPRN_SPRG0));
-		printf("pvr  = "REG"  sprg1= "REG"\n",
+		printf("pvr    = "REG"  sprg1 = "REG"\n",
 		       mfspr(SPRN_PVR), mfspr(SPRN_SPRG1));
-		printf("dec  = "REG"  sprg2= "REG"\n",
+		printf("dec    = "REG"  sprg2 = "REG"\n",
 		       mfspr(SPRN_DEC), mfspr(SPRN_SPRG2));
-		printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
-		printf("toc  = "REG"  dar  = "REG"\n", toc, mfspr(SPRN_DAR));
+		printf("sp     = "REG"  sprg3 = "REG"\n", sp, mfspr(SPRN_SPRG3));
+		printf("toc    = "REG"  dar   = "REG"\n", toc, mfspr(SPRN_DAR));
+
 		return;
 	}
 	case 'w': {
-- 
2.7.4
