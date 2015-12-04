Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C98C11A0CCC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:18:36 +1100 (AEDT)
Date: Fri, 4 Dec 2015 22:42:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Kim Phillips <kim.phillips@freescale.com>,
 David S Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: talitos - add new crypto modes
Message-ID: <20151204144210.GF17703@gondor.apana.org.au>
References: <20151201114415.97E331A2438@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151201114415.97E331A2438@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 01, 2015 at 12:44:15PM +0100, Christophe Leroy wrote:
> This patch adds the following algorithms to the talitos driver:
> * ecb(aes)
> * ctr(aes)
> * ecb(des)
> * cbc(des)
> * ecb(des3_ede)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
