Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9651E2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 17:01:35 +1000 (EST)
Date: Fri, 9 Aug 2013 16:30:03 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] drivers/crypto/nx: saves chaining value from
 co-processor
Message-ID: <20130809063003.GB23506@gondor.apana.org.au>
References: <1375917350.16050.14.camel@what-is-leg>
 <1376029504.32100.16.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376029504.32100.16.camel@pasglop>
Cc: Fionnuala Gunter <fin@linux.vnet.ibm.com>, mhcerri@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 09, 2013 at 04:25:04PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-07 at 18:15 -0500, Fionnuala Gunter wrote:
> > This patch fixes a bug that is triggered when cts(cbc(aes)) is used with
> > nx-crypto driver on input larger than 32 bytes.
> > 
> > The chaining value from co-processor was not being saved. This value is
> > needed because it is used as the IV by cts(cbc(aes)).
> > 
> > Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> > Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
> 
> Herbert, I assume you will handle this along with all the other NX fixes
> and I can safely take them out of linuxppc patchwork ?

Yes of course.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
