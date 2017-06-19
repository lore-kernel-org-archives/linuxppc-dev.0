Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrhf10HXVzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 16:58:48 +1000 (AEST)
Date: Mon, 19 Jun 2017 14:38:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martin Hicks <mort@bork.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 stable@vger.kernel.org, horia.geanta@nxp.com
Subject: Re: [PATCH v2] crypto: talitos: Extend max key length for
 SHA384/512-HMAC and AEAD
Message-ID: <20170619063824.GA13667@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502133835.GA17402@darwin.bork.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Martin Hicks <mort@bork.org> wrote:
> 
> An updated patch that also handles the additional key length requirements
> for the AEAD algorithms.
> 
> The max keysize is not 96.  For SHA384/512 it's 128, and for the AEAD
> algorithms it's longer still.  Extend the max keysize for the
> AEAD size for AES256 + HMAC(SHA512).
> 
> Cc: <stable@vger.kernel.org> # 3.6+
> Fixes: 357fb60502ede ("crypto: talitos - add sha224, sha384 and sha512 to existing AEAD algorithms")
> Signed-off-by: Martin Hicks <mort@bork.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
