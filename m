Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqclT4nJCzDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 19:58:28 +1000 (AEST)
Date: Wed, 20 Apr 2016 17:58:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: crash in ppc4xx-rng on canyonland
Message-ID: <20160420095815.GA3003@gondor.apana.org.au>
References: <20160418095939.GA18915@gondor.apana.org.au>
 <14761928.ine93l7C6D@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14761928.ine93l7C6D@debian64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2016 at 01:42:49PM +0200, Christian Lamparter wrote:
>
> what else I fixed in v1->v2: 
>  - added a check to test trng device's status state with
>    of_device_is_available.
>  - if the hwrng device registration failed, the flag which
>    enables the trng was left enabled (note: the v1 code
>    disabled the hwrng device as part of crypto4xx_remove.
>    so it wasn't enabled when the crypto4xx driver was
>    unloaded)

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
