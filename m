Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BE40B7B7D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 10:13:30 +1000 (EST)
Subject: Re: Fw: [PATCH] ppc: add ppc750 CL as supported by oprofile
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20090924170541.5cdffc06.akpm@linux-foundation.org>
References: <20090924170541.5cdffc06.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 10:13:02 +1000
Message-Id: <1253837582.7103.482.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dragos Tatulea <dtatulea@ixiacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 17:05 -0700, Andrew Morton wrote:
> 
> Begin forwarded message:

Thanks. I'll pick it up.

Cheers,
Ben.

> Date: Wed, 16 Sep 009 11:58:15 +0300
> From: Dragos Tatulea <dtatulea@ixiacom.com>
> To: paulus@samba.org, linux-kernel@vger.kernel.org
> Cc: Octavian Purdila <opurdila@ixiacom.com>
> Subject: [PATCH] ppc: add ppc750 CL as supported by oprofile
> 
> 
> Hi,
> 
> 	Here's a patch that adds the ppc750 CL cpu as supported by oprofile.
> 
> -- Dragos
> 
> Signed-off-by: Dragos Tatulea <dtatulea@ixiacom.com>
> ---
>  arch/powerpc/kernel/cputable.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 0b9c913..03c862b 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -711,6 +711,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_setup		= __setup_cpu_750,
>  		.machine_check		= machine_check_generic,
>  		.platform		= "ppc750",
> +		.oprofile_cpu_type      = "ppc/750",
> +		.oprofile_type		= PPC_OPROFILE_G4,
>  	},
>  	{	/* 745/755 */
>  		.pvr_mask		= 0xfffff000,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
