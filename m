Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB57DDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 10:59:09 +1000 (EST)
Subject: Re: [2.6 patch] powerpc: remove duplicate 6xx option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20080717181828.GA18326@cs181140183.pp.htv.fi>
References: <20080717181828.GA18326@cs181140183.pp.htv.fi>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 10:58:58 +1000
Message-Id: <1216601938.11027.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 21:18 +0300, Adrian Bunk wrote:
> The real option is above in the same Kconfig file.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Thanks, I'll pick that up.

Cheers,
Ben.
 
> ---
> 2251e74345df51309579a0a5fd8339e2f14762b9 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 5bc4b61..6489d57 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -84,9 +84,6 @@ config TUNE_CELL
>  	  machines. When building a kernel that is supposed to run only
>  	  on Cell, you should also select the POWER4_ONLY option.
>  
> -config 6xx
> -	bool
> -
>  # this is temp to handle compat with arch=ppc
>  config 8xx
>  	bool
