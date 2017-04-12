Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w34Zp1Y4NzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:31:46 +1000 (AEST)
In-Reply-To: <deac3bce31ca651b57de32524387d8ecd2fcf8f6.1490194710.git.ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,
 1/4] powernv: Move CPU-Offline idle state invocation from smp.c to
 idle.c
Message-Id: <3w34Zp0ZCrz9sNV@ozlabs.org>
Date: Wed, 12 Apr 2017 23:31:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 15:04:14 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Move the piece of code in powernv/smp.c::pnv_smp_cpu_kill_self() which
> transitions the CPU to the deepest available platform idle state to a
> new function named pnv_cpu_offline() in powernv/idle.c. The rationale
> behind this code movement is that the data required to determine the
> deepest available platform state resides in powernv/idle.c.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7cd88da97040513e17cd77ae3e577

cheers
