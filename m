Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGv3vw1zDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:23 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-22-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [21/21] powerpc: Add missing prototypes in setup_32.c
Message-Id: <401RGt3MVRz9sVs@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:36 UTC, Mathieu Malaterre wrote:
> This commit add the prototypes for the following function:
> 
> - early_init
> - machine_init
> - ppc_setup_l2cr
> - ppc_setup_l3cr
> - ppc_init
> 
> the other missing ones were already added in setup.h previously. Fix the
> following warnings (treated as error in W=1):
> 
>   AR      init/built-in.o
> arch/powerpc/kernel/setup_32.c:68:30: error: no previous prototype for ‘early_init’ [-Werror=missing-prototypes]
>  notrace unsigned long __init early_init(unsigned long dt_ptr)
>                               ^~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:99:21: error: no previous prototype for ‘machine_init’ [-Werror=missing-prototypes]
>  notrace void __init machine_init(u64 dt_ptr)
>                      ^~~~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:124:12: error: no previous prototype for ‘ppc_setup_l2cr’ [-Werror=missing-prototypes]
>  int __init ppc_setup_l2cr(char *str)
>             ^~~~~~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:137:12: error: no previous prototype for ‘ppc_setup_l3cr’ [-Werror=missing-prototypes]
>  int __init ppc_setup_l3cr(char *str)
>             ^~~~~~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:183:12: error: no previous prototype for ‘ppc_init’ [-Werror=missing-prototypes]
>  int __init ppc_init(void)
>             ^~~~~~~~
> arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
>  void __init irqstack_early_init(void)
>              ^~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
>  void __init setup_power_save(void)
>              ^~~~~~~~~~~~~~~~
> arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]
>  __init void initialize_cache_info(void)
>              ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e82d70cf965072a3872ea97b7d8df4

cheers
