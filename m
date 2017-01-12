Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzhqP5VZQzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:30:41 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0CAT5Kf019324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 05:30:39 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27x3ata1ms-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 05:30:38 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 12 Jan 2017 16:00:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E736F125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 16:02:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0CAUXbE35389650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 16:00:33 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0CAUVwV020270
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 16:00:33 +0530
Date: Thu, 12 Jan 2017 16:00:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/64: Add BPF_JIT to powernv and pseries
 defconfigs
References: <20170112101734.5608-1-anton@ozlabs.org>
 <20170112101734.5608-2-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112101734.5608-2-anton@ozlabs.org>
Message-Id: <20170112103026.GB3470@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/01/12 09:17PM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Commit db9112173b18 ("powerpc: Turn on BPF_JIT in ppc64_defconfig")
> only added BPF_JIT to the ppc64 defconfig. Add it to our powernv
> and pseries defconfigs too.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Thanks!
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


> ---
>  arch/powerpc/configs/powernv_defconfig | 1 +
>  arch/powerpc/configs/pseries_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index e4d53fe..b793550 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -79,6 +79,7 @@ CONFIG_NETFILTER=y
>  # CONFIG_NETFILTER_ADVANCED is not set
>  CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
> +CONFIG_BPF_JIT=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index 5a06bdd..d99734f 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -82,6 +82,7 @@ CONFIG_NETFILTER=y
>  # CONFIG_NETFILTER_ADVANCED is not set
>  CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
> +CONFIG_BPF_JIT=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> -- 
> 2.9.3
> 
