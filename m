Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 390D12C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 21:50:44 +1000 (EST)
Date: Wed, 21 Aug 2013 21:50:35 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmlatten@linux.vnet.ibm.com
Subject: Re: [PATCH] crypto:nx - fix nx-aes-gcm verification
Message-ID: <20130821115035.GD23287@gondor.apana.org.au>
References: <520c0215.kHFgBNcJQfAPXpv3%jmlatten@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520c0215.kHFgBNcJQfAPXpv3%jmlatten@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 14, 2013 at 05:17:57PM -0500, jmlatten@linux.vnet.ibm.com wrote:
> This patch fixes a bug in the nx-aes-gcm implementation.
> Corrected the code so that the authtag is always verified after
> decrypting and not just when there is associated data included.
> Also, corrected the code to retrieve the input authtag from src
> instead of dst. 
> 
> Reviewed-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
> Signed-off-by: Joy Latten <jmlatten@linux.vnet.ibm.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
