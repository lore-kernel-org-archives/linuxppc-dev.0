Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PrcM1rKyzF1S0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 00:39:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org,
	aik@ozlabs.ru
Subject: [PATCH 4/5] powerpc/lib: Rename ftr_fixup_test7 to
 ftr_fixup_test_too_big
Date: Tue, 17 Apr 2018 00:39:04 +1000
Message-Id: <20180416143905.2716-4-mpe@ellerman.id.au>
In-Reply-To: <20180416143905.2716-1-mpe@ellerman.id.au>
References: <20180416143905.2716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want this to remain the last test (because it's disabled by
default), so give it a non-numbered name so we don't have to renumber
it when adding new tests before it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups-test.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index 12ff0f673956..dd05afcbcde3 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -176,7 +176,7 @@ globl(ftr_fixup_test6_expected)
 /* Test that if we have a larger else case the assembler spots it and
  * reports an error. #if 0'ed so as not to break the build normally.
  */
-ftr_fixup_test7:
+ftr_fixup_test_too_big:
 	or	1,1,1
 BEGIN_FTR_SECTION
 	or	2,2,2
-- 
2.14.1
