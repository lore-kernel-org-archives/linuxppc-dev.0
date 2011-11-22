Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 12E13B7091
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2011 07:25:17 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAMKPCpt012732
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Nov 2011 14:25:13 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix building ppc64 w/hugetlbfs enabled
Date: Tue, 22 Nov 2011 14:25:12 -0600
Message-Id: <1321993512-941-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/setup_64.c: In function 'early_setup':
arch/powerpc/kernel/setup_64.c:226:2: error: implicit declaration of function 'reserve_hugetlb_gpages'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 66648cc..6a98051 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -65,6 +65,7 @@
 #include <asm/kexec.h>
 #include <asm/mmu_context.h>
 #include <asm/code-patching.h>
+#include <asm/hugetlb.h>
 
 #include "setup.h"
 
-- 
1.7.3.4
