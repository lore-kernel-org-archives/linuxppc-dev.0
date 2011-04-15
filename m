Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (helcar.apana.org.au [209.40.204.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F0331007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 19:51:04 +1000 (EST)
Date: Fri, 15 Apr 2011 17:50:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/4] crypto: caam - handle interrupt lines shared
	across rings
Message-ID: <20110415095049.GA2129@gondor.apana.org.au>
References: <20110411191516.bae0454e.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110411191516.bae0454e.kim.phillips@freescale.com>
Cc: Steve Cornelius <sec@pobox.com>, linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 11, 2011 at 07:15:16PM -0500, Kim Phillips wrote:
> - add IRQF_SHARED to request_irq flags to support parts such as
> the p1023 that has one IRQ line per couple of rings.
> 
> - resetting a job ring triggers an interrupt, so move request_irq
> prior to jr_reset to avoid 'got IRQ but nobody cared' messages.
> 
> - disable IRQs in h/w to avoid contention between reset and
> interrupt status
> 
> - delete invalid comment - if there were incomplete jobs,
> module would be in use, preventing an unload.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> this, and the remaining patches in this series, tested on p1023, p3041,
> p4080, and 32- and 64-bit p5020.

All four patches applied.  Thanks Kim!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
