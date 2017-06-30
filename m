Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzXL33XvYzDr51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 20:08:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: laurentiu.tudor@nxp.com, oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] powerpc: allow compiling with GENERIC_MSI_IRQ
In-Reply-To: <20170630095022.17228-1-laurentiu.tudor@nxp.com>
References: <20170630095022.17228-1-laurentiu.tudor@nxp.com>
Date: Fri, 30 Jun 2017 20:08:42 +1000
Message-ID: <8737ahrdn9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laurentiu,

laurentiu.tudor@nxp.com writes:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> This allows building powerpc with the GENERIC_MSI_IRQ Kconfig
> by enabling the asm-generic msi.h in Kbuild. Without this,
> there's a compilation error [1] because powerpc, as most arches,
> doesn't provide an asm/msi.h.
>
> [1] In file included from ./include/linux/kvm_host.h:20:0,
>                  from ./arch/powerpc/include/asm/kvm_ppc.h:30,
>                  from arch/powerpc/kernel/dbell.c:20:
> ./include/linux/msi.h:195:21: fatal error: asm/msi.h: No such file or directory

I have >50 configs here with GENERIC_MSI_IRQ=y, so I don't understand
what's going wrong for you.

Can you tell me more about what you're doing and how it's breaking.

cheers
