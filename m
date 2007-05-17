Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13706DDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:49:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4HIjsRP024894
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:45:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HInWEV222910
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HInWPq031968
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:32 -0600
Received: from [9.10.86.203] (skynet.rchland.ibm.com [9.10.86.203])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4HInWVq031915
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:32 -0600
Message-ID: <464CA3BC.5050301@linux.vnet.ibm.com>
Date: Thu, 17 May 2007 13:49:32 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: fix #endif comment
References: <464B50B6.3090300@us.ibm.com>
In-Reply-To: <464B50B6.3090300@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resubmitting with white space damage repaired.

Fix #endif comments to match #if.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
----

 hash_utils_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 028ba4e..4f2f453 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -430,7 +430,7 @@ static void __init htab_finish_init(void)
 	make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
 	make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
 	make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 
 	make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
 	make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
@@ -837,7 +837,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	if (mm->context.user_psize == MMU_PAGE_64K)
 		__hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 		__hash_page_4K(ea, access, vsid, ptep, trap, local);
 
 	local_irq_restore(flags);
