Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (sting.hengli.com.au [178.18.18.71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA6E82C00A6
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 19:05:25 +1000 (EST)
Date: Mon, 20 Aug 2012 16:31:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/crypto: Remove virt_to_abs() usage in nx-842.c
Message-ID: <20120820083130.GB22951@gondor.apana.org.au>
References: <1343960595-30232-1-git-send-email-michael@ellerman.id.au>
 <501BE2F6.5080506@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <501BE2F6.5080506@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2012 at 09:40:54AM -0500, Seth Jennings wrote:
> On 08/02/2012 09:23 PM, Michael Ellerman wrote:
> > virt_to_abs() is just a wrapper around __pa(), use __pa() directly.
> > 
> > We should be including <asm/page.h> to get __pa(). abs_addr.h will be
> > removed shortly so drop that.
> > 
> > We were getting of.h via abs_addr.h so we need to include that directly.
> > 
> > Having done all that, clean up the ordering of the includes.
> > 
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >  drivers/crypto/nx/nx-842.c |   34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> Looks good here.  Thanks for doing this!
> 
> Acked-by: Seth Jennings <sjenning@linux.vnet.ibm.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
