Return-Path: <srs0=g+o6=h6=gondor.apana.org.au=herbert@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jGNp1LzgzF2jV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 02:52:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40jGNn52fkz8syK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 02:52:41 +1000 (AEST)
Date: Sat, 12 May 2018 00:19:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, mhcerri@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] crypto: vmx - Remove overly verbose printk from AES
 XTS init
Message-ID: <20180511161926.bboeiec6fjjrg2rk@gondor.apana.org.au>
References: <20180503122930.17448-1-mpe@ellerman.id.au>
 <20180503122930.17448-2-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503122930.17448-2-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 10:29:30PM +1000, Michael Ellerman wrote:
> In p8_aes_xts_init() we do a printk(KERN_INFO ...) to report the
> fallback implementation we're using. However with a slow console this
> can significantly affect the speed of crypto operations. So remove it.
> 
> Fixes: c07f5d3da643 ("crypto: vmx - Adding support for XTS")
> Cc: stable@vger.kernel.org # v4.8+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/crypto/vmx/aes_xts.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
