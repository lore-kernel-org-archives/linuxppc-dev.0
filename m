Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqf32gZzF1kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:50 +1000 (AEST)
In-Reply-To: <20180522061428.5142-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] selftests/powerpc: Add ptrace hw breakpoint test
Message-Id: <40skqd5tMfz9s33@ozlabs.org>
Date: Fri, 25 May 2018 21:41:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-22 at 06:14:27 UTC, Michael Neuling wrote:
> This test the ptrace hw breakpoints via PTRACE_SET_DEBUGREG and
> PPC_PTRACE_SETHWDEBUG.  This test was use to find the bugs fixed by
> these recent commits:
> 
>   4f7c06e26e powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG
>   cd6ef7eebf powerpc/ptrace: Fix enforcement of DAWR constraints
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c2ddfe55c42bf4b9bc336a0650ab7

cheers
