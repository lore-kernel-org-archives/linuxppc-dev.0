Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Lkl3Xb5zDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 01:22:39 +1000 (AEST)
Date: Mon, 8 Aug 2016 23:22:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: anton@samba.org, anton@ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, davem@davemloft.net, alastair@d-silva.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: crc32c-vpmsum - Convert to CPU feature based
 module autoloading
Message-ID: <20160808152209.GA31540@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y44biu7s.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> This is actually an arch/powerpc patch, so I'll merge it unless Herbert
> objects.

It's fine with me.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
