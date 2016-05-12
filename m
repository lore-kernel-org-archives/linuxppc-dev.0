Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5DXM11mQzDqZL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:36:03 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Thu, 12 May 2016 23:36:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0FB532CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:35:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4CDZmG111076054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:35:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4CDYrfS014362
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:34:53 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, aik@au1.ibm.com,
 mpe@ellerman.id.au, Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH v2 1/2] powerpc,
 numa: Fix whitespace in hot_add_drconf_memory_max()
Date: Thu, 12 May 2016 19:04:14 +0530
Message-Id: <1463060055-24158-2-git-send-email-bharata@linux.vnet.ibm.com>
In-Reply-To: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..4a87ccb 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1163,18 +1163,18 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 static u64 hot_add_drconf_memory_max(void)
 {
-        struct device_node *memory = NULL;
-        unsigned int drconf_cell_cnt = 0;
-        u64 lmb_size = 0;
+	struct device_node *memory = NULL;
+	unsigned int drconf_cell_cnt = 0;
+	u64 lmb_size = 0;
 	const __be32 *dm = NULL;
 
-        memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-        if (memory) {
-                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-                lmb_size = of_get_lmb_size(memory);
-                of_node_put(memory);
-        }
-        return lmb_size * drconf_cell_cnt;
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (memory) {
+		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
+		lmb_size = of_get_lmb_size(memory);
+		of_node_put(memory);
+	}
+	return lmb_size * drconf_cell_cnt;
 }
 
 /*
-- 
2.1.0
