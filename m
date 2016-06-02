Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6H44NgCzDqcd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:12 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:39:10 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v5 01/11] powerpc/powernv: Use PNV_THREAD_WINKLE macro while
 requesting for winkle
Date: Thu,  2 Jun 2016 07:38:51 -0500
Message-Id: <1464871141-11568-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
-No changes in v5

Changes in v4
=============
- New in v4

 arch/powerpc/kernel/idle_power7.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 470ceeb..705c867 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -252,7 +252,7 @@ _GLOBAL(power7_sleep)
 	/* No return */
 
 _GLOBAL(power7_winkle)
-	li	r3,3
+	li	r3,PNV_THREAD_WINKLE
 	li	r4,1
 	b	power7_powersave_common
 	/* No return */
-- 
2.1.4
