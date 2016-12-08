Return-Path: <hejianet@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ17l1TlnzDw2d
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 14:29:39 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id m48so47393897qta.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 19:29:39 -0800 (PST)
From: Jia He <hejianet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com,
 shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Jia He <hejianet@gmail.com>
Subject: [PATCH] powerpc: Fix LPCR_VRMASD definition
Date: Thu,  8 Dec 2016 11:29:30 +0800
Message-Id: <1481167770-7042-1-git-send-email-hejianet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes: a4b349540a ("powerpc/mm: Cleanup LPCR defines")
Signed-off-by: Jia He <hejianet@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9e1499f..93ec25e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -337,7 +337,7 @@
 #define   LPCR_DPFD_SH		52
 #define   LPCR_DPFD		(ASM_CONST(7) << LPCR_DPFD_SH)
 #define   LPCR_VRMASD_SH	47
-#define   LPCR_VRMASD		(ASM_CONST(1) << LPCR_VRMASD_SH)
+#define   LPCR_VRMASD		(ASM_CONST(0x1f) << LPCR_VRMASD_SH)
 #define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
 #define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
 #define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
-- 
2.5.5
