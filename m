Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58d2wmjzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:45 +1100 (AEDT)
In-Reply-To: <1464841788-17465-2-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [2/3] powerpc/asm: Define STACK_OFFSET macro in asm-offsets.c
Message-Id: <3vP58d2BVYz9s8Y@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-02 at 04:29:47 UTC, Rashmica Gupta wrote:
> There are quite a few entries in asm-offests.c look like this:
> DEFINE(REG, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, reg));
> 
> So define a local MACRO to clean this up:
> STACK_OFFSET(sym, val) DEFINE(sym, STACK_FRAME_OVERHEAD + \
>                offsetof(struct pt_regs, val))
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/10d4cf188ab26a4ebeee4c914e82ac

cheers
