Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 371851A1262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 19:46:17 +1100 (AEDT)
Date: Thu, 17 Dec 2015 16:45:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: segher@kernel.crashing.org, ddstreet@ieee.org, davem@davemloft.net,
 pair@us.ibm.com, mpe@ellerman.id.au, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/nx842: Mask XERS0 bit in return value
Message-ID: <20151217084555.GA9239@gondor.apana.org.au>
References: <1450006242.19568.11.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450006242.19568.11.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 13, 2015 at 03:30:41AM -0800, Haren Myneni wrote:
> 
> NX842 coprocessor sets 3rd bit in CR register with XER[S0] which is
> nothing to do with NX request. Since this bit can be set with other
> valuable return status, mast this bit.
> 
> One of other bits (INITIATED, BUSY or REJECTED) will be returned for
> any given NX request.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
