Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BE711A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 19:58:46 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 14:28:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 60DAC125801E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:28:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAO8wLQv6095088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:28:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAO8wKhS019360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 14:28:21 +0530
Message-ID: <565426AC.7030402@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 14:28:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 02/31] powerpc/mm: move pte headers to book3s directory
 (part 2)
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> diff --git a/arch/powerpc/include/asm/pte-hash64-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> similarity index 99%
> rename from arch/powerpc/include/asm/pte-hash64-4k.h
> rename to arch/powerpc/include/asm/book3s/64/hash-4k.h
> index c134e809aac3..79750fd3eeb8 100644
> --- a/arch/powerpc/include/asm/pte-hash64-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -14,4 +14,3 @@
>  
>  /* shift to put page number into pte */
>  #define PTE_RPN_SHIFT	(17)
> -

Is there any specific reason to remove this one line while
renaming & moving the header file ? It will be cleaner not
to make any changes to the header while moving it around.
