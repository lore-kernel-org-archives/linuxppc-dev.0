Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdP6LT2zF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:21 +1000 (AEST)
In-Reply-To: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/powernv/idle: Fix build error
Message-Id: <41ptdP4Qqsz9sCX@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-09 at 13:37:20 UTC, "Aneesh Kumar K.V" wrote:
> Fix the below build error using strlcpy instead of strncpy
> 
> In function 'pnv_parse_cpuidle_dt',
>     inlined from 'pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:840:7,
>     inlined from '__machine_initcall_powernv_pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:870:1:
> arch/powerpc/platforms/powernv/idle.c:820:3: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>    strncpy(pnv_idle_states[i].name, temp_string[i],
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     PNV_IDLE_NAME_LEN);
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ae24ce5e12127eeef6bf946c3ee0e9

cheers
