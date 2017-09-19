Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxNHD68w6zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 22:59:03 +1000 (AEST)
Message-Id: <cover.1505825623.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/6] crypto: talitos - various fixes
To: Herbert Xu <herbert@gondor.apana.org.au>,
 David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Tue, 19 Sep 2017 14:58:59 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie provide various fixes on the talitos driver.

Christophe Leroy (6):
  crypto: talitos - Don't provide setkey for non hmac hashing algs.
  crypto: talitos - fix hashing
  crypto: talitos - fix sha224
  crypto: talitos - fix AEAD test failures
  crypto: talitos - use kzalloc instead of kmalloc
  crypto: talitos - fix memory corruption on SEC2

 drivers/crypto/talitos.c | 81 +++++++++++++++++++++---------------------------
 drivers/crypto/talitos.h |  2 --
 2 files changed, 36 insertions(+), 47 deletions(-)

-- 
2.13.3
