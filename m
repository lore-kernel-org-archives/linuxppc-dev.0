Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk3l2RpWzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:03:47 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id r5so6878803lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:03:47 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0211/1529] Fix typo
Date: Sat, 21 May 2016 14:03:38 +0200
Message-Id: <20160521120338.10915-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/crypto/aes-spe-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/aes-spe-regs.h b/arch/powerpc/crypto/aes-spe-regs.h
index 30d217b..2cc3a2c 100644
--- a/arch/powerpc/crypto/aes-spe-regs.h
+++ b/arch/powerpc/crypto/aes-spe-regs.h
@@ -18,7 +18,7 @@
 #define rLN r7	/* length of data to be processed			*/
 #define rIP r8	/* potiner to IV (CBC/CTR/XTS modes)			*/
 #define rKT r9	/* pointer to tweak key (XTS mode)			*/
-#define rT0 r11	/* pointers to en-/decrpytion tables			*/
+#define rT0 r11	/* pointers to en-/decryption tables			*/
 #define rT1 r10
 #define rD0 r9	/* data 						*/
 #define rD1 r14
-- 
2.8.2.534.g1f66975
