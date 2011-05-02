Return-Path: <R1AAHA@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 371861007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 09:27:48 +1000 (EST)
Date: Mon, 2 May 2011 18:27:27 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] crypto: caam - handle interrupt lines shared across
	rings
Message-ID: <20110502182727.366857bd.kim.phillips@freescale.com>
In-Reply-To: <20110415095049.GA2129@gondor.apana.org.au>
References: <20110411191516.bae0454e.kim.phillips@freescale.com>
	<20110415095049.GA2129@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Fri, 15 Apr 2011 17:50:49 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Mon, Apr 11, 2011 at 07:15:16PM -0500, Kim Phillips wrote:
> > - add IRQF_SHARED to request_irq flags to support parts such as
> > the p1023 that has one IRQ line per couple of rings.
> > 
> > - resetting a job ring triggers an interrupt, so move request_irq
> > prior to jr_reset to avoid 'got IRQ but nobody cared' messages.
> > 
> > - disable IRQs in h/w to avoid contention between reset and
> > interrupt status
> > 
> > - delete invalid comment - if there were incomplete jobs,
> > module would be in use, preventing an unload.
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> > this, and the remaining patches in this series, tested on p1023, p3041,
> > p4080, and 32- and 64-bit p5020.
> 
> All four patches applied.  Thanks Kim!

I don't see them in cryptodev-2.6 - did you forget to push them?

Thanks,

Kim
