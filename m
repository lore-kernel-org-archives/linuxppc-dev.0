Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNZdW68f0zDqfV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 23:03:43 +1000 (AEST)
Message-Id: <7db7c030af80d42c06a4900de317ca7afe6258c3.1464390096.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1464390094.git.christophe.leroy@c-s.fr>
References: <cover.1464390094.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/7] crypto: talitos - sg_to_link_tbl() not used anymore,
 remove it
To: Kim Phillips <kim.phillips@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Mon,  6 Jun 2016 13:20:42 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4ff03c3..ff8cf39 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1111,14 +1111,6 @@ next:
 	return count;
 }
 
-static inline int sg_to_link_tbl(struct scatterlist *sg, int sg_count,
-				 int cryptlen,
-				 struct talitos_ptr *link_tbl_ptr)
-{
-	return sg_to_link_tbl_offset(sg, sg_count, 0, cryptlen,
-				     link_tbl_ptr);
-}
-
 int talitos_sg_map(struct device *dev, struct scatterlist *src,
 		   unsigned int len, struct talitos_edesc *edesc,
 		   struct talitos_ptr *ptr,
-- 
2.1.0
