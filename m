Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F083B1A0569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:37 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 21:48:36 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6FB121FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:36:43 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mXHd32505874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:33 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mXDj015065
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:33 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 01/18] powerp/mm: Update code comments
Date: Tue, 23 Feb 2016 10:18:03 +0530
Message-Id: <1456202900-5454-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
