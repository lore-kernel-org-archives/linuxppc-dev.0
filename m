Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGl6Yc2zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:15 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-19-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [18/21] powerpc: Add missing prototypes for sys_sigreturn &
 sys_rt_sigreturn
Message-Id: <401RGl2jsdz9sD0@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:33 UTC, Mathieu Malaterre wrote:
> Two functions did not have a prototype defined in signal.h header. Fix the
> following two warnings (treated as errors in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c:1135:6: error: no previous prototype for ‘sys_rt_sigreturn’ [-Werror=missing-prototypes]
>  long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
>       ^~~~~~~~~~~~~~~~
> arch/powerpc/kernel/signal_32.c:1422:6: error: no previous prototype for ‘sys_sigreturn’ [-Werror=missing-prototypes]
>  long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
>       ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b53875c4b4f212a7a8e505e2d10635

cheers
