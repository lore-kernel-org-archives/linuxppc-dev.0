Return-Path: <mpm@selenic.com>
Received: from waste.org (waste.org [173.11.57.241])
	by ozlabs.org (Postfix) with ESMTP id C4C7AB6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 05:00:02 +1000 (EST)
Subject: Re: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
From: Matt Mackall <mpm@selenic.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20110621113836.fbf14710.kim.phillips@freescale.com>
References: <20110621121955.GB2414@zod.rchland.ibm.com>
	<1308671762.4954.0.camel@calx>
	<20110621113836.fbf14710.kim.phillips@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Jun 2011 13:59:55 -0500
Message-ID: <1308682795.4954.42.camel@calx>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-21 at 11:38 -0500, Kim Phillips wrote:
> [adding linux-crypto]
> 
> On Tue, 21 Jun 2011 10:56:02 -0500
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > On Tue, 2011-06-21 at 08:19 -0400, Josh Boyer wrote:
> > > +static struct hwrng ppc4xx_rng = {
> > > +	.name = MODULE_NAME,
> > > +	.data_present = ppc4xx_rng_data_present,
> > > +	.data_read = ppc4xx_rng_data_read,
> > > +};
> 
> under what criteria should new hwrng drivers use the new hwrng API?

If the RNG is not fundamentally u32-based (like this one), it's strongly
encouraged. We'll eventually abandon the old interface, but I don't
think there's any hurry.

-- 
Mathematics is the supreme nostalgia of our time.
