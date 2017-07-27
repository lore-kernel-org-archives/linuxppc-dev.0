Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBM357hHzDrJ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:19 +1000 (AEST)
In-Reply-To: <20170717131243.2157-1-laurentiu.tudor@nxp.com>
To: laurentiu.tudor@nxp.com, <oss@buserror.net>,
 <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [v2] powerpc: allow compiling with GENERIC_MSI_IRQ_DOMAIN
Message-Id: <3xJBM32VLlz9s76@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 13:12:43 UTC, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This allows building powerpc with the GENERIC_MSI_IRQ_DOMAIN
> Kconfig by enabling the asm-generic msi.h in Kbuild. Without
> this, there's a compilation error [1] because powerpc, as most
> arches, doesn't provide an asm/msi.h.
> 
> [1] In file included from ./include/linux/kvm_host.h:20:0,
>                  from ./arch/powerpc/include/asm/kvm_ppc.h:30,
>                  from arch/powerpc/kernel/dbell.c:20:
> ./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or directory
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8f36479d0eda3c078ee4e1ec79ea9a

cheers
