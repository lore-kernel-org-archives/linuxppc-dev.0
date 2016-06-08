Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPbCt0qjQzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 14:33:30 +1000 (AEST)
In-Reply-To: <1464860457-29253-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Update LPCR HR bit as per ISA
Message-Id: <3rPbCs72HMz9sp7@ozlabs.org>
Date: Wed,  8 Jun 2016 14:33:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-06 at 09:40:57 UTC, "Aneesh Kumar K.V" wrote:
> We need to se HR bit LPCR for radix partitions.
 
Please update the change log with something similar to what Ben sent.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h  | 1 +
>  arch/powerpc/mm/pgtable-radix.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index c1e82e968506..652147ef5ae3 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -348,6 +348,7 @@
>  #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
>  #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
>  #define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
> +#define	  LPCR_HR      0x00100000

What is this bit? Where is it documented?

Also white space is wrong.

cheers
