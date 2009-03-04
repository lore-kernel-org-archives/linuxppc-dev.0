Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A22FDDF83
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 15:48:06 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc: oprofile: enable support for ppc750
	processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Octavian Purdila <opurdila@ixiacom.com>
In-Reply-To: <1231246535-13151-3-git-send-email-opurdila@ixiacom.com>
References: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
	<1231246535-13151-3-git-send-email-opurdila@ixiacom.com>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 15:47:58 +1100
Message-Id: <1236142078.6696.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-06 at 14:55 +0200, Octavian Purdila wrote:
> Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>


So I'm going to merge 1/2 but this one should really be changed to
advertise ppc/750 in oprofile_cpu_type (ie. to userspace).

Cheers,
Ben.

>  arch/powerpc/kernel/cputable.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 923f87a..4e20cfb 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -726,6 +726,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_setup		= __setup_cpu_750,
>  		.machine_check		= machine_check_generic,
>  		.platform		= "ppc750",
> +		.oprofile_cpu_type      = "ppc/7450",
> +		.oprofile_type		= PPC_OPROFILE_G4,
>  	},
>  	{	/* 750FX rev 2.0 must disable HID0[DPM] */
>  		.pvr_mask		= 0xffffffff,
> @@ -741,6 +743,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_setup		= __setup_cpu_750,
>  		.machine_check		= machine_check_generic,
>  		.platform		= "ppc750",
> +		.oprofile_cpu_type      = "ppc/7450",
> +		.oprofile_type		= PPC_OPROFILE_G4,
>  	},
>  	{	/* 750FX (All revs except 2.0) */
>  		.pvr_mask		= 0xffff0000,
> @@ -756,6 +760,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_setup		= __setup_cpu_750fx,
>  		.machine_check		= machine_check_generic,
>  		.platform		= "ppc750",
> +		.oprofile_cpu_type      = "ppc/7450",
> +		.oprofile_type		= PPC_OPROFILE_G4,
>  	},
>  	{	/* 750GX */
>  		.pvr_mask		= 0xffff0000,
