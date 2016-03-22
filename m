Return-Path: <alokn73@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTnpg389YzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 20:44:26 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n5so34720740pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 02:44:26 -0700 (PDT)
From: mistryalok <alokn73@gmail.com>
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alokn73@gmail.com
Subject: [PATCH] arch: powerpc: mm: fixed spelling error.
Date: Tue, 22 Mar 2016 15:13:55 +0530
Message-Id: <1458639835-5706-1-git-send-email-alokn73@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed spelling error.
Signed-off-by: Alok Mistry <alokn73@gmail.com>
---
 arch/powerpc/mm/hash64_64k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b2d659c..fe89a6d 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -91,7 +91,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
 
 		/*
-		 * No CPU has hugepages but lacks no execute, so we
+		 * No CPU has huge pages but lacks no execute, so we
 		 * don't need to worry about that case
 		 */
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
-- 
1.9.1
