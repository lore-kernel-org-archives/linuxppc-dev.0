Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFM13R2zDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:23 +1000 (AEST)
In-Reply-To: <1467090166-10261-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pseries: HVC early debug options should depend on
 HVC_CONSOLE
Message-Id: <3rsjFL6pPXz9t0V@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-28-06 at 05:02:46 UTC, Michael Ellerman wrote:
> The pseries HVC early debug options, CONFIG_PPC_EARLY_DEBUG_LPAR and
> CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI both require code that is part of the
> hvc driver. If we turn them on but not CONFIG_HVC_CONSOLE then we get:
> 
>   arch/powerpc/kernel/built-in.o: In function `.udbg_early_init':
>   arch/powerpc/kernel/built-in.o:(.debug_addr+0x9a00): undefined reference to `udbg_init_debug_lpar'
> 
> Similarly for HVSI. So make them both depend on CONFIG_HVC_CONSOLE.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/236977609a81150c4561c33fa6

cheers
