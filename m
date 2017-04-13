Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3kzZ4S3czDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 01:22:02 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DFEPAv113247
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:21:52 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t69a1aqw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:21:52 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 20:51:48 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3DFLkp018743336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:51:46 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3DFLj8b014896
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:51:45 +0530
Date: Thu, 13 Apr 2017 15:21:41 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/configs: Enable function trace by default
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170413070309.10497-1-bsingharora@gmail.com>
In-Reply-To: <20170413070309.10497-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492096766.sziet58dj7.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Balbir Singh's message of April 13, 2017 12:33:
> We expect to have these configs on by default, most
> distros turn them off, its always good to have them on
> so that we can use them and hopefully not break them

Thanks! I find myself constantly enabling these options.

>=20
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/configs/powernv_defconfig | 4 ++++
>  arch/powerpc/configs/ppc64_defconfig   | 3 +++
>  arch/powerpc/configs/pseries_defconfig | 3 +++
>  3 files changed, 10 insertions(+)
>=20
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/config=
s/powernv_defconfig
> index 0695ce0..eff3968 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -295,7 +295,11 @@ CONFIG_DEBUG_STACK_USAGE=3Dy
>  CONFIG_DEBUG_STACKOVERFLOW=3Dy
>  CONFIG_LOCKUP_DETECTOR=3Dy
>  CONFIG_LATENCYTOP=3Dy
> +CONFIG_FTRACE=3Dy
> +CONFIG_FUNCTION_TRACER=3Dy
> +CONFIG_FUNCTION_GRAPH_TRACER=3Dy
>  CONFIG_SCHED_TRACER=3Dy
> +CONFIG_FTRACE_SYSCALLS=3Dy

Any reason to not enable this for ppc64 and pseries defconfigs?
Apart from that, for this patch:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen

>  CONFIG_BLK_DEV_IO_TRACE=3Dy
>  CONFIG_UPROBE_EVENT=3Dy
>  CONFIG_CODE_PATCHING_SELFTEST=3Dy
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/=
ppc64_defconfig
> index e353168f9..17c6c12 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -328,6 +328,9 @@ CONFIG_DEBUG_STACKOVERFLOW=3Dy
>  CONFIG_LOCKUP_DETECTOR=3Dy
>  CONFIG_DEBUG_MUTEXES=3Dy
>  CONFIG_LATENCYTOP=3Dy
> +CONFIG_FTRACE=3Dy
> +CONFIG_FUNCTION_TRACER=3Dy
> +CONFIG_FUNCTION_GRAPH_TRACER=3Dy
>  CONFIG_SCHED_TRACER=3Dy
>  CONFIG_BLK_DEV_IO_TRACE=3Dy
>  CONFIG_UPROBE_EVENT=3Dy
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/config=
s/pseries_defconfig
> index 1a61aa2..a445960 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -293,6 +293,9 @@ CONFIG_DEBUG_STACK_USAGE=3Dy
>  CONFIG_DEBUG_STACKOVERFLOW=3Dy
>  CONFIG_LOCKUP_DETECTOR=3Dy
>  CONFIG_LATENCYTOP=3Dy
> +CONFIG_FTRACE=3Dy
> +CONFIG_FUNCTION_TRACER=3Dy
> +CONFIG_FUNCTION_GRAPH_TRACER=3Dy
>  CONFIG_SCHED_TRACER=3Dy
>  CONFIG_BLK_DEV_IO_TRACE=3Dy
>  CONFIG_UPROBE_EVENT=3Dy
> --=20
> 2.9.3
>=20
>=20
=
