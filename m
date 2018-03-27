Return-Path: <srs1=ryo/=kernel.org==zz8a=gr=goodmis.org=rostedt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409h1D3hs5zF29x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 06:30:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 409h1D2Rggz8vKp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 06:30:08 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 409h1C3Zqpz9s0b
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2018 06:30:06 +1100 (AEDT)
Date: Tue, 27 Mar 2018 15:30:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc: Only support DYNAMIC_FTRACE not static
Message-ID: <20180327153002.5475a057@gandalf.local.home>
In-Reply-To: <20180327042906.32461-1-mpe@ellerman.id.au>
References: <20180327042906.32461-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 Mar 2018 15:29:06 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> We've had dynamic ftrace support for over 9 years since Steve first
> wrote it, all the distros use dynamic, and static is basically
> untested these days, so drop support for static ftrace.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  arch/powerpc/Kconfig                           |  1 +
>  arch/powerpc/include/asm/ftrace.h              |  4 +---
>  arch/powerpc/kernel/trace/ftrace.c             |  2 --
>  arch/powerpc/kernel/trace/ftrace_32.S          | 20 ------------------
>  arch/powerpc/kernel/trace/ftrace_64.S          | 29 --------------------------
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  3 ---
>  arch/powerpc/kernel/trace/ftrace_64_pg.S       |  2 --
>  7 files changed, 2 insertions(+), 59 deletions(-)
>
