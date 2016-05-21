Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk5X5XZczDqKx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:20 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id 65so28449lfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:20 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0221/1529] Fix typo
Date: Sat, 21 May 2016 14:05:12 +0200
Message-Id: <20160521120512.11484-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/include/asm/tsi108.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/tsi108.h b/arch/powerpc/include/asm/tsi108.h
index d531d9e..c2a955b 100644
--- a/arch/powerpc/include/asm/tsi108.h
+++ b/arch/powerpc/include/asm/tsi108.h
@@ -77,7 +77,7 @@
  * nodes if your board uses the Broadcom PHYs
  */
 #define TSI108_PHY_MV88E	0	/* Marvel 88Exxxx PHY */
-#define TSI108_PHY_BCM54XX	1	/* Broardcom BCM54xx PHY */
+#define TSI108_PHY_BCM54XX	1	/* Broadcom BCM54xx PHY */
 
 /* Global variables */
 
-- 
2.8.2.534.g1f66975
