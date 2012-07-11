Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (sting.hengli.com.au [178.18.18.71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 929F22C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 13:24:09 +1000 (EST)
Date: Wed, 11 Jul 2012 11:24:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] Using alloc_coherent for caam job rings
Message-ID: <20120711032403.GA5263@gondor.apana.org.au>
References: <1340774912-19042-1-git-send-email-bharat.bhushan@freescale.com>
 <20120627143411.b33d3ddab40e67b511297dcd@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120627143411.b33d3ddab40e67b511297dcd@freescale.com>
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Bharat Bhushan <r65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2012 at 07:34:11PM +0000, Kim Phillips wrote:
> On Wed, 27 Jun 2012 10:58:32 +0530
> Bharat Bhushan <r65777@freescale.com> wrote:
> 
> > This resolves the Linux boot crash issue when "swiotlb=force" is set
> > in bootargs on systems which have memory more than 4G.
> 
> Acked-by: Kim Phillips <kim.phillips@freescale.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
