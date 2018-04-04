Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBc37B6zF1TR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:52 +1000 (AEST)
In-Reply-To: <20180401053813.17405-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv: Fix SMT4 forcing idle code
Message-Id: <40GTBc23sJz9s32@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-04-01 at 05:38:13 UTC, Nicholas Piggin wrote:
> PSSCR value is not stored to PACA_REQ_PSSCR in case the CPU does
> not have the XER[SO] bug.
> 
> Fix this by storing up-front, outside the workaround code. The
> initial test is not required because it is a slow path.
> 
> The workaround is made to depend on CONFIG_KVM_BOOK3S_HV_POSSIBLE, to
> match pnv_power9_force_smt4_catch() where it is used.
> 
> Fixes: 7672691a08 ("powerpc/powernv: Provide a way to force a core into SMT4 mode")
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a2b5e056b75ee6ef0777817644a456

cheers
