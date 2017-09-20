Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxtNy5Fb8zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 18:35:46 +1000 (AEST)
Subject: Re: [PATCH 0/6] crypto: talitos - various fixes
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
References: <cover.1505825623.git.christophe.leroy@c-s.fr>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d1a928d5-d5cd-baf6-a6bf-2375cce4b4a4@c-s.fr>
Date: Wed, 20 Sep 2017 10:35:41 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1505825623.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks like the linux-crypto list and patchwork was out of order when I 
sent this. I will send again, sorry for the noise on the other lists.

Le 19/09/2017 à 14:58, Christophe Leroy a écrit :
> This serie provide various fixes on the talitos driver.
> 
> Christophe Leroy (6):
>    crypto: talitos - Don't provide setkey for non hmac hashing algs.
>    crypto: talitos - fix hashing
>    crypto: talitos - fix sha224
>    crypto: talitos - fix AEAD test failures
>    crypto: talitos - use kzalloc instead of kmalloc
>    crypto: talitos - fix memory corruption on SEC2
> 
>   drivers/crypto/talitos.c | 81 +++++++++++++++++++++---------------------------
>   drivers/crypto/talitos.h |  2 --
>   2 files changed, 36 insertions(+), 47 deletions(-)
> 
