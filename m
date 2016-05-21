Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8m6c69zDqPv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:08 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id d132so1684590lfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:08 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0242/1529] Fix typo
Date: Sat, 21 May 2016 14:08:02 +0200
Message-Id: <20160521120802.12631-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 7553b6a..6d6f277 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -15,7 +15,7 @@
  * This file thus provides a simple low level unified i2c interface for
  * powermac that covers the various types of i2c busses used in Apple machines.
  * For now, keywest, PMU and SMU, though we could add Cuda, or other bit
- * banging busses found on older chipstes in earlier machines if we ever need
+ * banging busses found on older chipsets in earlier machines if we ever need
  * one of them.
  *
  * The drivers in this file are synchronous/blocking. In addition, the
-- 
2.8.2.534.g1f66975
