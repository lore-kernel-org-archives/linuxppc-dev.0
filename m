Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E04C91A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:29:43 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 02:29:41 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2B77E38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 02:29:38 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u217Tc9426935540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 07:29:38 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u217TboL018853
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 02:29:37 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/8] powerp/mm: Update code comments
Date: Tue,  1 Mar 2016 12:59:17 +0530
Message-Id: <1456817364-3329-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are updating pte in those functions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c  | 2 +-
 arch/powerpc/mm/hash64_64k.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index e7c04542ba62..e3e76b929f33 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -106,7 +106,7 @@ repeat:
 			}
 		}
 		/*
-		 * Hypervisor failure. Restore old pmd and return -1
+		 * Hypervisor failure. Restore old pte and return -1
 		 * similar to __hash_page_*
 		 */
 		if (unlikely(slot == -2)) {
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index ef6fac6d773c..b2d659cf51c6 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -188,7 +188,7 @@ repeat:
 		}
 	}
 	/*
-	 * Hypervisor failure. Restore old pmd and return -1
+	 * Hypervisor failure. Restore old pte and return -1
 	 * similar to __hash_page_*
 	 */
 	if (unlikely(slot == -2)) {
@@ -310,7 +310,7 @@ repeat:
 			}
 		}
 		/*
-		 * Hypervisor failure. Restore old pmd and return -1
+		 * Hypervisor failure. Restore old pte and return -1
 		 * similar to __hash_page_*
 		 */
 		if (unlikely(slot == -2)) {
-- 
2.5.0
