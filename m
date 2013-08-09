Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 56E9A2C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 16:42:30 +1000 (EST)
Date: Fri, 9 Aug 2013 16:42:22 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] drivers/crypto/nx: fixes when input data is too
 large
Message-ID: <20130809064222.GA23834@gondor.apana.org.au>
References: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 02, 2013 at 12:09:50PM +0000, Marcelo Cerri wrote:
> This series of patches fixes two bugs that are triggered when the input data is
> too large. The first one is caused by the miscalculation of physical addresses
> and the second one by some limits that the co-processor has to the input data.
> 
> Changes in v2:
>         * Replace Signed-Off-By tags with Reviewed-By tags where it is
> 	  appropriate.
> 
> Marcelo Cerri (2):
>   drivers/crypto/nx: fix physical addresses added to sg lists
>   drivers/crypto/nx: fix limits to sg lists for SHA-2

Both patches applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
