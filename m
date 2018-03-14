Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGq0CbFzDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:19 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-20-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [19/21] powerpc: Add missing prototypes for hw_breakpoint_handler
 & arch_unregister_hw_breakpoint
Message-Id: <401RGn3kfmz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:34 UTC, Mathieu Malaterre wrote:
> In commit 5aae8a537080 ("powerpc, hw_breakpoints: Implement hw_breakpoints
> for 64-bit server processors") function hw_breakpoint_handler and
> arch_unregister_hw_breakpoint were added without function prototypes in
> hw_breakpoint.h header.
> 
> Fix the following warning(s) (treated as error in W=1):
> 
>   AR      init/built-in.o
> arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for ‘arch_unregister_hw_breakpoint’ [-Werror=missing-prototypes]
>  void arch_unregister_hw_breakpoint(struct perf_event *bp)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/hw_breakpoint.c:209:5: error: no previous prototype for ‘hw_breakpoint_handler’ [-Werror=missing-prototypes]
>  int hw_breakpoint_handler(struct die_args *args)
>      ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0d876da1d1cd33a1c28049512a136

cheers
