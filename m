Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk4F2fBjzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:13 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id r5so6879092lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:13 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, scottwood@freescale.com,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0214/1529] Fix typo
Date: Sat, 21 May 2016 14:04:04 +0200
Message-Id: <20160521120404.11079-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/include/asm/nohash/32/pte-44x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index fdab41c..0656ff8 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -32,7 +32,7 @@
  *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW SR
  *
  * Newer 440 cores (440x6 as used on AMCC 460EX/460GT) have additional
- * TLB2 storage attibute fields. Those are:
+ * TLB2 storage attribute fields. Those are:
  *
  *   TLB2:
  *   0...10    11   12   13   14   15   16...31
-- 
2.8.2.534.g1f66975
