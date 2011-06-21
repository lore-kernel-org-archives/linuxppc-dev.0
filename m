Return-Path: <R1AAHA@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8BE07B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 02:39:06 +1000 (EST)
Date: Tue, 21 Jun 2011 11:38:36 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
Message-ID: <20110621113836.fbf14710.kim.phillips@freescale.com>
In-Reply-To: <1308671762.4954.0.camel@calx>
References: <20110621121955.GB2414@zod.rchland.ibm.com>
	<1308671762.4954.0.camel@calx>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

[adding linux-crypto]

On Tue, 21 Jun 2011 10:56:02 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Tue, 2011-06-21 at 08:19 -0400, Josh Boyer wrote:
> > +static struct hwrng ppc4xx_rng = {
> > +	.name = MODULE_NAME,
> > +	.data_present = ppc4xx_rng_data_present,
> > +	.data_read = ppc4xx_rng_data_read,
> > +};

under what criteria should new hwrng drivers use the new hwrng API?

See commit bb347d9 "hwrng: virtio-rng - Convert to new API".

Kim
