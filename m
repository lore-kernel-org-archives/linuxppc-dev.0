Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3XNd5SznzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:24:33 +1000 (AEST)
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
References: <20170413070309.10497-1-bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <eea3c818-f5ca-4cd9-c715-307104534970@c-s.fr>
Date: Thu, 13 Apr 2017 09:24:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170413070309.10497-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Baldir

Le 13/04/2017 à 09:03, Balbir Singh a écrit :
> We expect to have these configs on by default, most
> distros turn them off, its always good to have them on
> so that we can use them and hopefully not break them

Isn't it the purpose of the target allyesconfig to allow such tests ?

FTRACE is quite CPU consumming, shouldn't it really be on by default ?

Christophe

>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/configs/powernv_defconfig | 4 ++++
>  arch/powerpc/configs/ppc64_defconfig   | 3 +++
>  arch/powerpc/configs/pseries_defconfig | 3 +++
>  3 files changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 0695ce0..eff3968 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -295,7 +295,11 @@ CONFIG_DEBUG_STACK_USAGE=y
>  CONFIG_DEBUG_STACKOVERFLOW=y
>  CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_LATENCYTOP=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_FUNCTION_GRAPH_TRACER=y
>  CONFIG_SCHED_TRACER=y
> +CONFIG_FTRACE_SYSCALLS=y
>  CONFIG_BLK_DEV_IO_TRACE=y
>  CONFIG_UPROBE_EVENT=y
>  CONFIG_CODE_PATCHING_SELFTEST=y
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index e353168f9..17c6c12 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -328,6 +328,9 @@ CONFIG_DEBUG_STACKOVERFLOW=y
>  CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_DEBUG_MUTEXES=y
>  CONFIG_LATENCYTOP=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_FUNCTION_GRAPH_TRACER=y
>  CONFIG_SCHED_TRACER=y
>  CONFIG_BLK_DEV_IO_TRACE=y
>  CONFIG_UPROBE_EVENT=y
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index 1a61aa2..a445960 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -293,6 +293,9 @@ CONFIG_DEBUG_STACK_USAGE=y
>  CONFIG_DEBUG_STACKOVERFLOW=y
>  CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_LATENCYTOP=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_FUNCTION_GRAPH_TRACER=y
>  CONFIG_SCHED_TRACER=y
>  CONFIG_BLK_DEV_IO_TRACE=y
>  CONFIG_UPROBE_EVENT=y
>
