Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB9E3DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 09:59:51 +1100 (EST)
Subject: Re: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070205185836.099816000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.099816000@sipsolutions.net>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 09:59:36 +1100
Message-Id: <1170716376.2620.141.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> plain text document attachment (irq-comment.patch)
> kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Morton <akpm@osdl.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- mb-wireless.orig/arch/powerpc/kernel/irq.c	2007-02-05 14:24:06.694526864 +0100
> +++ mb-wireless/arch/powerpc/kernel/irq.c	2007-02-05 14:24:37.084526864 +0100
> @@ -281,10 +281,10 @@ void do_IRQ(struct pt_regs *regs)
>  
>  	/*
>  	 * Every platform is required to implement ppc_md.get_irq.
> -	 * This function will either return an irq number or -1 to
> +	 * This function will either return an irq number or NO_IRQ to
>  	 * indicate there are no more pending.
> -	 * The value -2 is for buggy hardware and means that this IRQ
> -	 * has already been handled. -- Tom
> +	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
> +	 * IRQ has already been handled. -- Tom
>  	 */
>  	irq = ppc_md.get_irq();
>  
> 
> --
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
