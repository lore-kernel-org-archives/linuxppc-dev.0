Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE9A967D34
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:23:33 +1100 (EST)
Subject: Re: [patch 06/16] powerpc: remove _machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125626.263838000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125626.263838000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:23:28 +1100
Message-Id: <1162506208.10630.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 13:56 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (powerpc-include-asm-powerpc-processor_h-remove-_machine.diff)
> The _machine macro was once used for compatibility with ARCH=ppc
> drivers. It is unused in current kernels
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: include/asm-powerpc/processor.h
> ===================================================================
> --- a/include/asm-powerpc/processor.h.orig
> +++ b/include/asm-powerpc/processor.h
> @@ -53,10 +53,6 @@ extern unsigned char ucBoardRevMaj, ucBo
>  
>  #endif /* CONFIG_PPC_PREP */
>  
> -#ifndef CONFIG_PPC_MULTIPLATFORM
> -#define _machine 0
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> -
>  #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
>  
>  /*
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
