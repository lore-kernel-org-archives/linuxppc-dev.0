Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A786DDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 15:59:34 +1000 (EST)
In-Reply-To: <20070611233354.289486461@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233354.289486461@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F72846CE-5742-4413-A2EB-AC1B4080048E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 06/10] powerpc: multiplatformize embedded6xx Kconfig
Date: Tue, 12 Jun 2007 00:59:53 -0500
To: arnd@arndb.de
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2007, at 6:28 PM, arnd@arndb.de wrote:

> The existing embedded 6xx platforms will happily coexist
> with each other in a single kernel if you let them.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Index: linux-2.6/arch/powerpc/platforms/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/Kconfig
> @@ -12,10 +12,6 @@ config PPC_MULTIPLATFORM
>  	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
>  	  Maple or Cell-based machine.
>
> -config EMBEDDED6xx
> -	bool "Embedded 6xx/7xx/7xxx-based board"
> -	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
> -

Do we know why this was marked BROKEN?

- k
