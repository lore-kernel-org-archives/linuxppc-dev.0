Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgC5xyrzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:03 +1000 (AEST)
In-Reply-To: <1526980357-25385-2-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com
Subject: Re: [v2,1/4] powerpc/perf: Rearrange memory freeing in imc init
Message-Id: <40zxgC0BYwz9s4n@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-22 at 09:12:34 UTC, Anju T Sudhakar wrote:
> When any of the IMC (In-Memory Collection counter) devices fail
> to initialize, imc_common_mem_free() frees set of memory. In doing so,
> pmu_ptr pointer is also freed. But pmu_ptr pointer is used in subsequent
> function (imc_common_cpuhp_mem_free()) which is wrong. Patch here reorders
> the code to avoid such access.
> 
> Also free the memory which is dynamically allocated during imc
> initialization, wherever required.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cb094fa5af7c9623084aa4c3cf529b

cheers
