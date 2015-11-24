Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CFA51A0066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 20:15:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 14:45:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BFBA6E0063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:45:34 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAO9D6L349742050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:43:07 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAO9D6Is009696
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:43:06 +0530
Message-ID: <56542A21.9030703@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 14:43:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 03/31] powerpc/mm: make a separate copy for book3s
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> +++ b/arch/powerpc/include/asm/book3s/pgtable.h
> @@ -0,0 +1,10 @@
> +#ifndef _ASM_POWERPC_BOOK3S_PGTABLE_H
> +#define _ASM_POWERPC_BOOK3S_PGTABLE_H
> +
> +#ifdef CONFIG_PPC64
> +#include <asm/book3s/64/pgtable.h>
> +#else
> +#include <asm/book3s/32/pgtable.h>
> +#endif
> +
> +#endif

Just as other headers, you may want to change the last line
as the following.

#endif /* _ASM_POWERPC_BOOK3S_PGTABLE_H */
