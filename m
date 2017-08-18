Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjcn2zY8zDr9H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:51:05 +1000 (AEST)
In-Reply-To: <1502900494-10010-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Fix usage of nest_imc_refc
Message-Id: <3xYjcm6L2Nz9t3f@ozlabs.org>
Date: Fri, 18 Aug 2017 22:51:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-16 at 16:21:34 UTC, Madhavan Srinivasan wrote:
> nest_imc_refc is a reference count struct,
> used to track number of active perf sessions
> using the nest units.
> 
> It is preferred to access nest_imc_refc using
> per-cpu pointer 'local_nest_imc_refc'. Since,
> nest_imc_refc is not initialized using node_id
> as array index. Patch to fix the same.
> 
> Fixes: 885dcd709ba91 ('powerpc/perf: Add nest IMC PMU support')
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/711bd207a233141308d0aea0d2e286

cheers
