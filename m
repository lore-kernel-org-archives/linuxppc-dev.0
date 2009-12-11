Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E8A6B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 08:59:58 +1100 (EST)
Subject: Re: [RFC PATCH v2 3/6] powerpc: broadway processor support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-4-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-4-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 08:59:52 +1100
Message-ID: <1260568792.16132.362.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 23:47 +0100, Albert Herranz wrote:
> This patch extends the cputable entry of the 750CL to also match
> the 750CL-based "Broadway" cpu found on the Nintendo Wii.
> 
> As of this patch, the following "Broadway" design revision levels have
> been seen in the wild:
> - DD1.2 (87102)
> - DD2.0 (87200)
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> ---
> v1 -> v2
> - Don't reorder the table. Suggestion by Grant Likely.
> 
>  arch/powerpc/kernel/cputable.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 03c862b..2fc82ba 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -697,9 +697,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check		= machine_check_generic,
>  		.platform		= "ppc750",
>  	},
> -	{	/* 750CL */
> -		.pvr_mask		= 0xfffff0f0,
> -		.pvr_value		= 0x00087010,
> +	{	/* 750CL (and "Broadway") */
> +		.pvr_mask		= 0xfffff0e0,
> +		.pvr_value		= 0x00087000,
>  		.cpu_name		= "750CL",
>  		.cpu_features		= CPU_FTRS_750CL,
>  		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
