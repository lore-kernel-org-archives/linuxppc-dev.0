Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzb48FlzDvmp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:15 +1100 (AEDT)
In-Reply-To: <1477008111-9160-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/book3s64: Always build for power4 or later
Message-Id: <3tHTzb1Wppz9t2g@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-21-10 at 00:01:51 UTC, Michael Ellerman wrote:
> When we're not compiling for a specific CPU, ie. none of the
> CONFIG_POWERx_CPU options are set, and CONFIG_GENERIC_CPU *is* set, we
> currently don't pass any -mcpu option to the compiler. This means the
> compiler builds for a "generic" Power CPU.
> 
> But back in 2014 we dropped support for pre power4 CPUs in commit
> 468a33028edd ("powerpc: Drop support for pre-POWER4 cpus").
> 
> Given that, there's no point in building the kernel to run on pre power4
> cpus. So update the flags we pass to the compiler when
> CONFIG_GENERIC_CPU is set, to specify -mcpu=power4.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3a849815a13695ad0e32f6f01c9054

cheers
