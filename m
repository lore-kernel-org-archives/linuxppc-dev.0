Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 1D2CEDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:20:57 +1100 (EST)
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1LUwfQ-00014g-C2
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2009 16:20:48 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>) id 1LUwfQ-000288-ES
	for linuxppc-dev@ozlabs.org; Thu, 05 Feb 2009 16:20:48 +1100
Resent-Message-ID: <20090205052048.GA8100@gondor.apana.org.au>
Date: Thu, 5 Feb 2009 16:18:39 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: James Hsiao <jhsiao@amcc.com>
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v6
Message-ID: <20090205051839.GC22749@gondor.apana.org.au>
References: <1233183185.4809.52.camel@jhsiao-usb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233183185.4809.52.camel@jhsiao-usb>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@ozlabs.or
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 28, 2009 at 02:53:05PM -0800, James Hsiao wrote:
> This patch adds support for AMCC ppc4xx security device driver. This is the
> initial release that includes the driver framework with AES and SHA1 algorithms
> support.
> The remaining algorithms will be released in the near future.
> 
> Signed-off-by: James Hsiao <jhsiao@amcc.com>

Patch applied.  Thanks James!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
