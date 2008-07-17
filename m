Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 1427EDE002
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:18:11 +1000 (EST)
Date: Thu, 17 Jul 2008 20:17:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/6] crypto: talitos - fix GFP flag usage
Message-ID: <20080717121758.GA25267@gondor.apana.org.au>
References: <20080716182215.36c1bd11.kim.phillips@freescale.com>
	<BDCB5191-EEDE-4046-A741-80E6EF1333CF@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BDCB5191-EEDE-4046-A741-80E6EF1333CF@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 06:33:45PM -0500, Kumar Gala wrote:
> 
> On Jul 16, 2008, at 6:22 PM, Kim Phillips wrote:
> 
> >use GFP_ATOMIC when necessary; use atomic_t when allocating  
> >submit_count.
> 
> why?

You mean why are atomics required? Yes that is a good question.

Kim?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
