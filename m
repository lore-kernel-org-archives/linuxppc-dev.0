Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC05267C3D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:52:14 +1000 (EST)
Subject: Re: [PATCH] Fix a printk in pseries_mpic_init_IRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20061003044846.5187D67C49@ozlabs.org>
References: <20061003044846.5187D67C49@ozlabs.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:50:33 +1000
Message-Id: <1159851033.5482.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-03 at 14:48 +1000, Michael Ellerman wrote:
> This should probably say "mpic" to save confusion.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  arch/powerpc/platforms/pseries/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: to-merge/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
> +++ to-merge/arch/powerpc/platforms/pseries/setup.c
> @@ -180,7 +180,7 @@ static void __init pseries_mpic_init_IRQ
>  
>  	cascade_irq = irq_of_parse_and_map(cascade, 0);
>  	if (cascade == NO_IRQ) {
> -		printk(KERN_ERR "xics: failed to map cascade interrupt");
> +		printk(KERN_ERR "mpic: failed to map cascade interrupt");
>  		return;
>  	}
>  
