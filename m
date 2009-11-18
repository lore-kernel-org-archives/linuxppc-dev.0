Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7A3B1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 04:55:38 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAIHtPVZ027397
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 10:55:25 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAIHtPJA017503
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:55:26 -0600 (CST)
Date: Wed, 18 Nov 2009 11:55:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 06/13] powerpc: Fixup last users of irq_chip->typename
Message-ID: <20091118175523.GA12857@b07421-ec1.am.freescale.net>
References: <20091117224852.846805939@linutronix.de>
	<20091117224916.566205413@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091117224916.566205413@linutronix.de>
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

On Tue, Nov 17, 2009 at 10:50:53PM +0000, Thomas Gleixner wrote:
> Index: linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> +++ linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> @@ -69,7 +69,7 @@ static void pq2ads_pci_unmask_irq(unsign
>  }
>  
>  static struct irq_chip pq2ads_pci_ic = {
> -	.typename = "PQ2 ADS PCI",
> +	.name = "PQ2 ADS PCI",
>  	.name = "PQ2 ADS PCI",
>  	.end = pq2ads_pci_unmask_irq,
>  	.mask = pq2ads_pci_mask_irq,

Duplicate ".name"...

-Scott
