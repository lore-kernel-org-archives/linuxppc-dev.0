Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzj2ZrxzDvms
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:21 +1100 (AEDT)
In-Reply-To: <1478151792-13500-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [v2] powerpc: EX_TABLE macro for exception tables
Message-Id: <3tHTzh6VcVz9t5m@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-11 at 05:43:12 UTC, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> This macro is taken from s390, and allows more flexibility in
> changing exception table format.
> 
> mpe: Put it in ppc_asm.h and only define one version using stringinfy_in_c().
> Add some empty definitions and headers to keep the selftests happy.
> Add some missing .previouses in fsl_rio.c and tsi108_pci.c.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/24bfa6a9e0d4fe414dfc4ad06c93e1

cheers
