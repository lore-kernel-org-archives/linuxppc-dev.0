Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EFCB1A167D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:47:49 +1100 (AEDT)
In-Reply-To: <20151210200405.4779b7df@kryten>
To: Anton Blanchard <anton@samba.org>, Rashmica <rashmicy@gmail.com>,
 Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, cyrilbur@gmail.com, scottwood@freescale.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Call check_if_tm_restore_required() in enable_kernel_*()
Message-Id: <20151214094749.7585914031F@ozlabs.org>
Date: Mon, 14 Dec 2015 20:47:49 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-12 at 09:04:05 UTC, Anton Blanchard wrote:
> Commit a0e72cf12b1a ("powerpc: Create msr_check_and_{set,clear}()")
> removed a call to check_if_tm_restore_required() in the
> enable_kernel_*() functions. Add them back in.
> 
> Fixes: a0e72cf12b1a ("powerpc: Create msr_check_and_{set,clear}()")
> Reported-by: Rashmica Gupta <rashmicy@gmail.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d64d02ce4ebaa79bf1c026e8

cheers
