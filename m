Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGm4nnSzDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:16 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-18-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [17/21] powerpc: Add missing prototype for sys_debug_setcontext
Message-Id: <401RGl6DS7z9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:32 UTC, Mathieu Malaterre wrote:
> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
> the function sys_debug_setcontext was added without a prototype.
> 
> Fix compilation warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
>  int sys_debug_setcontext(struct ucontext __user *ctx,
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0d60619e1c0ca20eb2610361034992

cheers
