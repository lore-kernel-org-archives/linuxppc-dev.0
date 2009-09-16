Return-Path: <weiyi.huang@gmail.com>
Received: from mail-px0-f184.google.com (mail-px0-f184.google.com
	[209.85.216.184]) by ozlabs.org (Postfix) with ESMTP id 9295FB7B7D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 23:09:36 +1000 (EST)
Received: by pxi14 with SMTP id 14so4159865pxi.9
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 06:09:35 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
To: galak@kernel.crashing.org
Subject: [PATCH 8/9] powerpc/mm: remove duplicated #include
Date: Wed, 16 Sep 2009 21:09:22 +0800
Message-Id: <1253106562-2680-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated #include('s) in
  arch/powerpc/mm/tlb_low_64e.S

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/powerpc/mm/tlb_low_64e.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index ef1cccf..f288279 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -18,7 +18,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 #include <asm/pgtable.h>
-#include <asm/reg.h>
 #include <asm/exception-64e.h>
 #include <asm/ppc-opcode.h>
 
-- 
1.6.1.3
