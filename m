Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06E251A0F53
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 20:20:33 +1000 (AEST)
In-Reply-To: <1433308225-13874-1-git-send-email-robh@kernel.org>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, linux-mips@linux-mips.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: of: clean-up unnecessary libfdt include paths
Message-Id: <20150604102032.DF5B4140280@ozlabs.org>
Date: Thu,  4 Jun 2015 20:20:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-06 at 05:10:25 UTC, Rob Herring wrote:
> With the latest dtc import include fixups, it is no longer necessary to
> add explicit include paths to use libfdt. Remove these across the
> kernel.

What are the "latest dtc import include fixups" ?

> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index c1ebbda..c16e836 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -2,7 +2,6 @@
>  # Makefile for the linux kernel.
>  #
>  
> -CFLAGS_prom.o		= -I$(src)/../../../scripts/dtc/libfdt
>  CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
>  
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
