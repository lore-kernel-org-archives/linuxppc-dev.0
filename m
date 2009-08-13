Return-Path: <herbert@gondor.apana.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7084EB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 12:37:05 +1000 (EST)
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id F3C50DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 12:37:04 +1000 (EST)
Date: Thu, 13 Aug 2009 11:52:09 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/3] crypto: talitos - simplify hmac data size calculation
Message-ID: <20090813015209.GA17783@gondor.apana.org.au>
References: <20090807183958.94650fb7.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090807183958.94650fb7.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 11:39:58PM +0000, Kim Phillips wrote:
> don't do request->src vs. assoc pointer math - it's the same as adding
> assoclen and ivsize (just with more effort).
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

All 3 patches applied.  Thanks Kim!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
