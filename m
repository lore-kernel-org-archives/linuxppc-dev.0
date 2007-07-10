Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 859C9DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 05:43:36 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: mjw@linux.vnet.ibm.com
Subject: Re: Resend: [PATCH] oprofile support for Power 5++ 
In-reply-to: <4693CC5B.4020207@linux.vnet.ibm.com> 
References: <4693CC5B.4020207@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2007 14:43:59 -0500
Message-ID: <14287.1184096639@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The patch has not been included and there have been no comments so
> I'm resending.
> 
> This patch adds a new oprofile cpu type for Power 5 revision 3 chips.
> The new name is ppc64/power5++ and is used so that the performance
> counters can be set up correctly.

Does it make more sense to call this "ppc64/power5+rev3"?  

Mikey

> 
> Signed-off-by: Mike Wolf <mjw@us.ibm.com>
> 
> -------- 
> linux-2.6.18.ppc64.orig/arch/powerpc/kernel/cputable.c	2006-09-19 22:4
2:06.000000000 -0500
> +++ linux-2.6.18.ppc64/arch/powerpc/kernel/cputable.c	2007-06-11 12:29:47.000
000000 -0500
> @@ -236,6 +236,21 @@
>  		.oprofile_mmcra_sipr	= MMCRA_SIPR,
>  		.platform		= "power5",
>  	},
> +	{	/* Power5++ */
> +		.pvr_mask		= 0xffffff00,
> +		.pvr_value		= 0x003b0300,
> +		.cpu_name		= "POWER5+ (gs)",
> +		.cpu_features		= CPU_FTRS_POWER5,
> +		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.num_pmcs		= 6,
> +		.oprofile_cpu_type	= "ppc64/power5++",
> +		.oprofile_type		= PPC_OPROFILE_POWER4,
> +		.oprofile_mmcra_sihv	= MMCRA_SIHV,
> +		.oprofile_mmcra_sipr	= MMCRA_SIPR,
> +		.platform		= "power5+",
> +	},
>  	{	/* Power5 GS */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x003b0000,
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
