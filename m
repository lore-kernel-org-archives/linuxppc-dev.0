Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzS090WyZzDr60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 16:52:57 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id f127so14390942pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:52:56 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/hugetlbfs: Export HPAGE_SHIFT
Date: Fri, 30 Jun 2017 16:52:35 +1000
Message-Id: <20170630065235.752-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export it so it can be referenced inside a module.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/hugetlbpage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index ceeab69cf7fc..96293560f294 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -34,6 +34,7 @@
 #define PAGE_SHIFT_16G	34
 
 unsigned int HPAGE_SHIFT;
+EXPORT_SYMBOL(HPAGE_SHIFT);
 
 /*
  * Tracks gpages after the device tree is scanned and before the
-- 
2.9.4
