Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97FE12C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 16:43:40 +1000 (EST)
Date: Fri, 9 Aug 2013 16:43:37 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] drivers/crypto/nx: saves chaining value from
 co-processor
Message-ID: <20130809064337.GC23834@gondor.apana.org.au>
References: <1375917350.16050.14.camel@what-is-leg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375917350.16050.14.camel@what-is-leg>
Cc: mhcerri@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 06:15:50PM -0500, Fionnuala Gunter wrote:
> This patch fixes a bug that is triggered when cts(cbc(aes)) is used with
> nx-crypto driver on input larger than 32 bytes.
> 
> The chaining value from co-processor was not being saved. This value is
> needed because it is used as the IV by cts(cbc(aes)).
> 
> Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
> ---
> v2. changed signed-off-by to reviewed-by and added more details to
> description
> 
> This bug appeared in the original submission (v3.5)

Patch applied.  However your patch was totally white-space damaged.
I've fixed it this time, but please fix this in your future
submissions.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
