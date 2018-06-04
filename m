Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfy462CzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:50 +1000 (AEST)
In-Reply-To: <20180510010424.16854-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/pmu/fsl: fix is_nmi test for irq mask change
Message-Id: <40zxfw02hwz9s5b@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-10 at 01:04:23 UTC, Nicholas Piggin wrote:
> When soft enabled was changed to irq disabled mask, this test missed
> being converted (although the equivalent book3s test was converted).
> 
> The PMU drivers consider it an NMI when they take a PMI while general
> interrupts are disabled. This change restores that behaviour.
> 
> Fixes: 01417c6cc7 ("powerpc/64: Change soft_enabled from flag to bitmask")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/81ea11d3af3aba0bea475dd1dd2f79

cheers
