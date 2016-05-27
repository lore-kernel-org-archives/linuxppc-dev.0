Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGLQY1CN1zDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 19:32:37 +1000 (AEST)
Message-Id: <cover.1464330501.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/6] crypto: talitos - implementation of AEAD for SEC1
To: Kim Phillips <kim.arm@arm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David S Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Date: Fri, 27 May 2016 11:32:32 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches provides the implementation of AEAD for
talitos SEC1.

Christophe Leroy (6):
  crypto: talitos - using helpers for all talitos_ptr operations
  crypto: talitos - making mapping helpers more generic
  crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU
  crypto: talitos - sg_to_link_tbl() not used anymore, remove it
  crypto: talitos - implement cra_priority
  crypto: talitos - templates for AEAD using HMAC_SNOOP_NO_AFEU

 drivers/crypto/talitos.c | 657 +++++++++++++++++++++++++++++------------------
 1 file changed, 410 insertions(+), 247 deletions(-)

-- 
2.1.0
