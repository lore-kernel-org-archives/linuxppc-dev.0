Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A156B6EFE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 07:41:36 +1100 (EST)
Date: Wed, 18 Nov 2009 21:41:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 06/13] powerpc: Fixup last users of irq_chip->typename
In-Reply-To: <20091118175523.GA12857@b07421-ec1.am.freescale.net>
Message-ID: <alpine.LFD.2.00.0911182141060.24119@localhost.localdomain>
References: <20091117224852.846805939@linutronix.de>
	<20091117224916.566205413@linutronix.de>
	<20091118175523.GA12857@b07421-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Nov 2009, Scott Wood wrote:
> On Tue, Nov 17, 2009 at 10:50:53PM +0000, Thomas Gleixner wrote:
> > Index: linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> > +++ linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> > @@ -69,7 +69,7 @@ static void pq2ads_pci_unmask_irq(unsign
> >  }
> >  
> >  static struct irq_chip pq2ads_pci_ic = {
> > -	.typename = "PQ2 ADS PCI",
> > +	.name = "PQ2 ADS PCI",
> >  	.name = "PQ2 ADS PCI",
> >  	.end = pq2ads_pci_unmask_irq,
> >  	.mask = pq2ads_pci_mask_irq,
> 
> Duplicate ".name"...

Darn.
