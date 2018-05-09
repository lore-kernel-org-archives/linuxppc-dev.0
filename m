Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.ozlabs.org (Postfix) with ESMTP id 40grMr5Nw0zF24c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 19:16:56 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Haren Myneni <haren@us.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: nx: fix spelling mistake: "seqeunce" -> "sequence"
Date: Wed,  9 May 2018 10:16:36 +0100
Message-Id: <20180509091636.13589-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in CSB_ERR error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 1e87637c412d..36afd6d8753c 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -334,7 +334,7 @@ static int wait_for_csb(struct nx842_workmem *wmem,
 		return -EPROTO;
 	case CSB_CC_SEQUENCE:
 		/* should not happen, we don't use chained CRBs */
-		CSB_ERR(csb, "CRB seqeunce number error");
+		CSB_ERR(csb, "CRB sequence number error");
 		return -EPROTO;
 	case CSB_CC_UNKNOWN_CODE:
 		CSB_ERR(csb, "Unknown subfunction code");
-- 
2.17.0
