Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ1dR4WhDzDt1j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 14:51:55 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB83omQ0043274
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 22:51:53 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 276w42hha3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 22:51:53 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 22:51:52 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Jia He <hejianet@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, shreyas@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>
Subject: Re: [PATCH] powerpc: Fix LPCR_VRMASD definition
In-Reply-To: <1481167770-7042-1-git-send-email-hejianet@gmail.com>
References: <1481167770-7042-1-git-send-email-hejianet@gmail.com>
Date: Thu, 08 Dec 2016 09:21:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3zrgjse.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia He <hejianet@gmail.com> writes:

> Fixes: a4b349540a ("powerpc/mm: Cleanup LPCR defines")
> Signed-off-by: Jia He <hejianet@gmail.com>

I sent another one https://lkml.kernel.org/r/20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com
to fix the same issue. I didn't notice this on the list. 


> ---
>  arch/powerpc/include/asm/reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 9e1499f..93ec25e 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -337,7 +337,7 @@
>  #define   LPCR_DPFD_SH		52
>  #define   LPCR_DPFD		(ASM_CONST(7) << LPCR_DPFD_SH)
>  #define   LPCR_VRMASD_SH	47
> -#define   LPCR_VRMASD		(ASM_CONST(1) << LPCR_VRMASD_SH)
> +#define   LPCR_VRMASD		(ASM_CONST(0x1f) << LPCR_VRMASD_SH)
>  #define   LPCR_VRMA_L		ASM_CONST(0x0008000000000000)
>  #define   LPCR_VRMA_LP0		ASM_CONST(0x0001000000000000)
>  #define   LPCR_VRMA_LP1		ASM_CONST(0x0000800000000000)
> -- 
> 2.5.5
