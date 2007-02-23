Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BF51BDDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 07:00:28 +1100 (EST)
Date: Fri, 23 Feb 2007 21:00:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: select default image for Linkstation
In-Reply-To: <20070222225202.35B9175694A@schermpje.krocht>
Message-ID: <Pine.LNX.4.60.0702232059120.8712@poirot.grange>
References: <20070222225202.35B9175694A@schermpje.krocht>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Feb 2007, Segher Boessenkool wrote:

> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Acked-by: G. Liakhovetski <g.liakhovetski@gmx.de>


> ---
>  arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -79,6 +79,7 @@
>  	select MPIC
>  	select FSL_SOC
>  	select PPC_UDBG_16550 if SERIAL_8250
> +	select DEFAULT_UIMAGE
>  	help
>  	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
>  	  based NAS systems from Buffalo Technology. So far only
> 

Thanks
Guennadi
---
Guennadi Liakhovetski
