Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 229E96868F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 14:01:40 +1100 (EST)
Date: Mon, 7 Nov 2005 19:01:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Message-Id: <20051107190128.68d41294.akpm@osdl.org>
In-Reply-To: <20051107124917.C1671@cox.net>
References: <20051107124917.C1671@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix perf_irq extern on e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> Add an extern reference to perf_irq on e500.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> 
> diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
> index 16adde6..ff1bdc2 100644
> --- a/arch/ppc/kernel/traps.c
> +++ b/arch/ppc/kernel/traps.c
> @@ -888,6 +888,8 @@ void altivec_assist_exception(struct pt_
>  #endif /* CONFIG_ALTIVEC */
>  
>  #ifdef CONFIG_E500
> +extern perf_irq_t perf_irq;
> +
>  void performance_monitor_exception(struct pt_regs *regs)
>  {
>  	perf_irq(regs);

extern decls are placed in header files, please.  
