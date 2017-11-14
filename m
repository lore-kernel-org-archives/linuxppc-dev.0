Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFt5rhzzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:02 +1100 (AEDT)
In-Reply-To: <1504662540-27527-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: andrew.donnellan@au1.ibm.com, arbab@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: Re: [v2,
 1/2] powerpc/npu: Use flush_all_mm() instead of flush_tlb_mm()
Message-Id: <3yblFt3LDkz9t2Q@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-06 at 01:48:59 UTC, Alistair Popple wrote:
> With the optimisations introduced by commit a46cc7a908 ("powerpc/mm/radix:
> Improve TLB/PWC flushes"), flush_tlb_mm() no longer flushes the page walk
> cache with radix. Switch to using flush_all_mm() to ensure the pwc and tlb
> are properly flushed on the nmmu.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2a31ad093bb1b8c1f1e04cbe222ad1

cheers
