Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybqjF2GqKzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 01:32:33 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Haren Myneni <haren@us.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2] crypto/nx: fix spelling mistake: "availavle" ->
 "available"
Date: Tue, 14 Nov 2017 14:32:17 +0000
Message-Id: <20171114143217.21456-1-colin.king@canonical.com>
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

Trivial fix to spelling mistake in pr_err error message text. Also
fix spelling mistake in proceeding comment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index f2246a5abcf6..1e87637c412d 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -743,8 +743,8 @@ static int nx842_open_percpu_txwins(void)
 		}
 
 		if (!per_cpu(cpu_txwin, i)) {
-			/* shoudn't happen, Each chip will have NX engine */
-			pr_err("NX engine is not availavle for CPU %d\n", i);
+			/* shouldn't happen, Each chip will have NX engine */
+			pr_err("NX engine is not available for CPU %d\n", i);
 			return -EINVAL;
 		}
 	}
-- 
2.14.1
