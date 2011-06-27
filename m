Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (helcar.apana.org.au [209.40.204.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F361B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 17:39:50 +1000 (EST)
Date: Mon, 27 Jun 2011 15:39:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
Message-ID: <20110627073939.GB9206@gondor.apana.org.au>
References: <20110621121955.GB2414@zod.rchland.ibm.com>
	<1308671762.4954.0.camel@calx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308671762.4954.0.camel@calx>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2011 at 10:56:02AM -0500, Matt Mackall wrote:
> On Tue, 2011-06-21 at 08:19 -0400, Josh Boyer wrote:
> > Various PowerPC 4xx SoCs contain a TRNG embedded in the Security function.
> > This adds a device driver for that TRNG.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Looks good.
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

Also applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
