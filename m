Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7473DDDEE7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:40:24 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add support for CoreInt delivery of
	interrupts onMPIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB12089136E4B@zch01exm21.fsl.freescale.net>
References: <1236772127-28543-1-git-send-email-galak@kernel.crashing.org>
	<D7CCA83BB0796C49BC0BB53B6AB12089136E4B@zch01exm21.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 16:40:14 +1100
Message-Id: <1237527614.25062.566.camel@pasglop>
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

On Wed, 2009-03-11 at 22:20 +0800, Liu Dave-R63238 wrote:
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -22,6 +22,7 @@
>  #define MPIC_GREG_FEATURE_1            0x00010
>  #define MPIC_GREG_GLOBAL_CONF_0                0x00020
>  #define                MPIC_GREG_GCONF_RESET
> 0x80000000
> +#define                MPIC_GREG_GCONF_COREINT
> 0x40000000
>  #define                MPIC_GREG_GCONF_8259_PTHROU_DIS
> 0x20000000
>  #define                MPIC_GREG_GCONF_NO_BIAS
> 0x10000000
>  #define                MPIC_GREG_GCONF_BASE_MASK
> 0x000fffff
> 
> 
> according to the latest UM, the MPIC_GREG_GCONF_COREINT should be
> 0x60000000.
> 
You mean 0x40000000 ? :-)

0x60000000 looks indeed bogus.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
