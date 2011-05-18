Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 677DA1007FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:38:29 +1000 (EST)
Subject: Re: [PATCH 7/7] powerpc/e5500: set MMU_FTR_USE_PAIRED_MAS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518210538.GF29524@schlenkerla.am.freescale.net>
References: <20110518210538.GF29524@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:38:19 +1000
Message-ID: <1305754699.7481.6.camel@pasglop>
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

On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Is there any 64-bit book3e chip that doesn't support this?  It
> doesn't appear to be optional in the ISA.

Not afaik.

Cheers,
Ben.

>  arch/powerpc/kernel/cputable.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 34d2722..a3b8eeb 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1981,7 +1981,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_features		= CPU_FTRS_E5500,
>  		.cpu_user_features	= COMMON_USER_BOOKE,
>  		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
> -			MMU_FTR_USE_TLBILX,
> +			MMU_FTR_USE_TLBILX | MMU_FTR_USE_PAIRED_MAS,
>  		.icache_bsize		= 64,
>  		.dcache_bsize		= 64,
>  		.num_pmcs		= 4,
