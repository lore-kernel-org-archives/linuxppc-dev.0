Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtl44xvzDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:39 +1100 (AEDT)
In-Reply-To: <1511327739-21688-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [v2,2/2] powerpc/perf: Fix IMC_MAX_PMU macro
Message-Id: <3yjrtl1ZdSz9t2Q@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-22 at 05:15:39 UTC, Madhavan Srinivasan wrote:
> IMC_MAX_PMU is used for static storage (per_nest_pmu_arr) which holds
> nest pmu information. Current value for the macro is 32 based on
> the initial number of nest pmu units supported by the nest microcode.
> But going forward, microcode could support more nest units. Instead
> of static storage, patch to fix the code to dynamically allocate an
> array based on the number of nest imc units found in the device tree.
> 
> Fixes:8f95faaac56c1 ('powerpc/powernv: Detect and create IMC device')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/73ce9aec65b17433e18163d07eb5cb

cheers
