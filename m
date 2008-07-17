Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 21D15DDFF7
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:17:35 +1000 (EST)
Date: Thu, 17 Jul 2008 20:17:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/6] crypto: talitos - remove calls to of_node_put
Message-ID: <20080717121719.GA25179@gondor.apana.org.au>
References: <20080716182146.0b095f5d.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080716182146.0b095f5d.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 06:21:46PM -0500, Kim Phillips wrote:
> From: Lee Nipper <lee.nipper@freescale.com>
> 
> Remove of_node_put calls since there is no corresponding of_node_get.
> This patch prevents an exception when talitos is loaded a 2nd time.
> This sequence: modprobe talitos; rmmod talitos; modprobe talitos
> causes this message: "WARNING: Bad of_node_put() on /soc8349@e0000000/crypto@30000".
> 
> Signed-off-by: Lee Nipper <lee.nipper@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

All applied to crpyto-2.6.  Thanks!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
