Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wg0-x243.google.com (mail-wg0-x243.google.com
 [IPv6:2a00:1450:400c:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA16D1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 20:54:26 +1000 (AEST)
Received: by wggx12 with SMTP id x12so13296746wgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 03:54:22 -0700 (PDT)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, ralf@linux-mips.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aaro.koskinen@iki.fi
Subject: [PATCH 1/6] crypto: md5: add MD5 initial vectors
Date: Sun, 17 May 2015 12:54:12 +0200
Message-Id: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 LABBE Corentin <clabbe.montjoie@gmail.com>, linux-crypto@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch simply adds the MD5 IV in the md5 header.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 include/crypto/md5.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/crypto/md5.h b/include/crypto/md5.h
index 65f299b..146af82 100644
--- a/include/crypto/md5.h
+++ b/include/crypto/md5.h
@@ -8,6 +8,11 @@
 #define MD5_BLOCK_WORDS		16
 #define MD5_HASH_WORDS		4
 
+#define MD5_H0	0x67452301UL
+#define MD5_H1	0xefcdab89UL
+#define MD5_H2	0x98badcfeUL
+#define MD5_H3	0x10325476UL
+
 struct md5_state {
 	u32 hash[MD5_HASH_WORDS];
 	u32 block[MD5_BLOCK_WORDS];
-- 
2.3.6
