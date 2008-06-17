Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C53ADDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 02:23:20 +1000 (EST)
Date: Tue, 17 Jun 2008 11:23:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
Message-ID: <20080617162309.GA3217@loki.buserror.net>
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 09:01:39AM -0500, Kumar Gala wrote:
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index f7efaa9..1a1ccfb 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -95,6 +95,11 @@ config E500
>  	select FSL_EMB_PERFMON
>  	bool
> 
> +config PPC_E500MC
> +	bool "e500mc Support"
> +	select PPC_FPU
> +	depends on E500

We should probably depend on !PPC_85xx until we can support such a
configuration, rather than have it break in less obvious ways.

-Scott
