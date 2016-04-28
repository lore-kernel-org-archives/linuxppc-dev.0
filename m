Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwbGt4zWQzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 22:09:26 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qwbGs6hDFz9t7M
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 22:09:25 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 17:39:23 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id ECF241258FF5
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 16:29:12 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3SAvELk4325774
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 16:27:15 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3SAvBZa023056
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2016 16:27:11 +0530
Date: Thu, 28 Apr 2016 16:27:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Define and use PPC_ELF_ABI_v2
Message-ID: <20160428105540.GA7880@naverao1-tp.in.ibm.com>
References: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/28 07:38PM, Michael Ellerman wrote:
> We're approaching 20 locations where we need to check for ELF ABI v2.
> That's fine, except the logic is a bit awkward, because we have to check
> that _CALL_ELF is defined and then what its value is.
> 
> So check it once in asm/types.h and define PPC_ELF_ABI_v2 when ELF ABI
> v2 is detected.
> 
> We don't add explicit includes of asm/types.h because it's included
> basically everywhere via compiler.h.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for doing this!

Does it make sense to call this PPC64_ELF_ABI_V2 since this is 64-bit 
only, and include check for CONFIG_PPC64 as well?

Apart from that:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
