Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cl4nlJzDqgJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:51 +1100 (AEDT)
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [1/2] powerpc/kdump: Add missing optional dummy functions
Message-Id: <3zh7cg63zDz9t67@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-02-12 at 22:34:07 UTC, Guenter Roeck wrote:
> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
> 
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
> 	implicit declaration of function 'crash_ipi_callback'
> 
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
> 
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/910961754572a2f4c83ad7e610d180

cheers
