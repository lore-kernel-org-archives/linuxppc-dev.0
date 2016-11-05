Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9lwG5V1MzDvNx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 15:24:30 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t9lwG1hF9z9t2p
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2016 15:24:30 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so9692076pfk.2
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Nov 2016 21:24:30 -0700 (PDT)
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] Fix a typo in radix encodings print
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <ec806870-b751-49f7-6717-bcebadff69a1@gmail.com>
Date: Sat, 5 Nov 2016 15:24:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename sift to shift

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cd3d400..ea7f796 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -248,7 +248,7 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
 		/* top 3 bit is AP encoding */
 		shift = be32_to_cpu(prop[0]) & ~(0xe << 28);
 		ap = be32_to_cpu(prop[0]) >> 29;
-		pr_info("Page size sift = %d AP=0x%x\n", shift, ap);
+		pr_info("Page size shift = %d AP=0x%x\n", shift, ap);
 
 		idx = get_idx_from_shift(shift);
 		if (idx < 0)
-- 
2.5.5
