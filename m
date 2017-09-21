Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyV5h2s1dzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 18:24:40 +1000 (AEST)
Date: Thu, 21 Sep 2017 16:06:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Stephan Muller <smueller@chronox.de>
Subject: Re: [PATCH] crypto: talitos - fix sha224
Message-ID: <20170921080617.GC7718@gondor.apana.org.au>
References: <20170913104451.75E8B684D7@po15668-vm-win7.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170913104451.75E8B684D7@po15668-vm-win7.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 13, 2017 at 12:44:51PM +0200, Christophe Leroy wrote:
> Kernel crypto tests report the following error at startup
> 
> [    2.752626] alg: hash: Test 4 failed for sha224-talitos
> [    2.757907] 00000000: 30 e2 86 e2 e7 8a dd 0d d7 eb 9f d5 83 fe f1 b0
> 00000010: 2d 5a 6c a5 f9 55 ea fd 0e 72 05 22
> 
> This patch fixes it
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
