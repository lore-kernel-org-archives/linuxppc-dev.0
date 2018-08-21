Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vd9R5PQXzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:34:00 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7L4XqeZ006183
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 00:33:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m09guva50-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 00:33:57 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 21 Aug 2018 05:33:56 +0100
Subject: Re: [PATCH] powerpc/powernv: Don't select the cpufreq governors
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Joel Stanley <joel@jms.id.au>, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Aug 2018 14:33:51 +1000
In-Reply-To: <20180821021428.23377-1-joel@jms.id.au>
References: <20180821021428.23377-1-joel@jms.id.au>
Mime-Version: 1.0
Message-Id: <d906da24481ac13eaaee986b61b389ae3b58575d.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-21 at 11:44 +0930, Joel Stanley wrote:
> Deciding wich govenors should be built into the kernel can be left to
> users to configure.
> 
> Fixes: 81f359027a3a ("cpufreq: powernv: Select CPUFreq related Kconfig options for powernv")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Can you add them to the defconfigs then ?

> ---
>  arch/powerpc/platforms/powernv/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index f8dc98d3dc01..028ac941c05c 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -15,11 +15,6 @@ config PPC_POWERNV
>  	select PPC_SCOM
>  	select ARCH_RANDOM
>  	select CPU_FREQ
> -	select CPU_FREQ_GOV_PERFORMANCE
> -	select CPU_FREQ_GOV_POWERSAVE
> -	select CPU_FREQ_GOV_USERSPACE
> -	select CPU_FREQ_GOV_ONDEMAND
> -	select CPU_FREQ_GOV_CONSERVATIVE
>  	select PPC_DOORBELL
>  	select MMU_NOTIFIER
>  	select FORCE_SMP
