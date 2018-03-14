Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGs4TTmzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:21 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-21-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [20/21] powerpc: Add missing prototypes for ppc_select &
 ppc_fadvise64_64
Message-Id: <401RGr5TpCz9sVZ@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:35 UTC, Mathieu Malaterre wrote:
> Add missing prototypes for ppc_select & ppc_fadvise64_64 to header
> asm-prototypes.h. Fix the following warnings (treated as errors in W=1)
> 
>   CC      arch/powerpc/kernel/syscalls.o
> arch/powerpc/kernel/syscalls.c:87:1: error: no previous prototype for ‘ppc_select’ [-Werror=missing-prototypes]
>  ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
>  ^~~~~~~~~~
> arch/powerpc/kernel/syscalls.c:119:6: error: no previous prototype for ‘ppc_fadvise64_64’ [-Werror=missing-prototypes]
>  long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
>       ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bf7fb32dd5fc8a6bd25aaab05d3acd

cheers
