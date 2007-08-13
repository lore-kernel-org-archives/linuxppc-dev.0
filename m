Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26013DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 02:57:31 +1000 (EST)
Subject: Re: [PATCH] via-pmu: Fix typo in printk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200708122238.34985.mb@bu3sch.de>
References: <200708122238.34985.mb@bu3sch.de>
Content-Type: text/plain
Date: Mon, 13 Aug 2007 11:57:21 -0500
Message-Id: <1187024241.5330.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-08-12 at 22:38 +0200, Michael Buesch wrote:
> This fixes a typo in a printk message.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> Index: linux-2.6/drivers/macintosh/via-pmu.c
> ===================================================================
> --- linux-2.6.orig/drivers/macintosh/via-pmu.c	2007-05-26 19:56:27.000000000 +0200
> +++ linux-2.6/drivers/macintosh/via-pmu.c	2007-08-12 22:36:27.000000000 +0200
> @@ -410,7 +410,7 @@ static int __init via_pmu_start(void)
>  
>  	irq = irq_of_parse_and_map(vias, 0);
>  	if (irq == NO_IRQ) {
> -		printk(KERN_ERR "via-pmu: can't map interruptn");
> +		printk(KERN_ERR "via-pmu: can't map interrupt\n");
>  		return -ENODEV;
>  	}
>  	if (request_irq(irq, via_pmu_interrupt, 0, "VIA-PMU", (void *)0)) {
> 
