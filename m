Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk5N3FHwzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:12 +1000 (AEST)
Received: by mail-lb0-x244.google.com with SMTP id t6so63159lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:12 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, adam.buchbinder@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0220/1529] Fix typo
Date: Sat, 21 May 2016 14:05:02 +0200
Message-Id: <20160521120502.11433-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/include/asm/smu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index f280dd1..9dc2de5 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -185,7 +185,7 @@
  *  x = processor mask
  *  y = op. point index
  *  z = processor freq. step index
- * I haven't yet decyphered result codes
+ * I haven't yet deciphered result codes
  *
  */
 #define SMU_CMD_POWER_COMMAND			0xaa
-- 
2.8.2.534.g1f66975
