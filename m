Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B64391A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:54:05 +1000 (AEST)
Message-ID: <1441004045.5735.8.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 1/9] powerpc: allocate sys_membarrier system call
 number
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 31 Aug 2015 16:54:05 +1000
In-Reply-To: <1440698215-8355-2-git-send-email-mathieu.desnoyers@efficios.com>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1440698215-8355-2-git-send-email-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-27 at 13:56 -0400, Mathieu Desnoyers wrote:
> Allow it to be used from SPU, since it should not have unwanted
> side-effects.
> 
> [ Untested on this architecture. To try it out: fetch linux-next/akpm,
>   apply this patch, build/run a membarrier-enabled kernel, and do make
>   kselftest. ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-api@vger.kernel.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: linuxppc-dev@lists.ozlabs.org

Thanks.

I get:

$ ./membarrier_test
membarrier MEMBARRIER_CMD_QUERY syscall available.
membarrier: MEMBARRIER_CMD_SHARED success.
membarrier: tests done!

Which looks good.

Assuming the membarrier support hits 4.3, I'll take this via my tree for 4.3
also.

cheers
