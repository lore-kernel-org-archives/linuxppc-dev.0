Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w25384zKJzDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:49:24 +1000 (AEST)
In-Reply-To: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/mm/radix: Don't do page walk cache flush when doing
 full mm flush
Message-Id: <3w25384G8Qz9sNB@ozlabs.org>
Date: Tue, 11 Apr 2017 08:49:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-04-01 at 14:41:47 UTC, "Aneesh Kumar K.V" wrote:
> For fullmm tlb flush, we do a flush with RIC_FLUSH_ALL which will invalidate all
> related caches (radix__tlb_flush()). Hence the pwc flush is not needed.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6b0df55cad252fedd60aa2ba75a02

cheers
