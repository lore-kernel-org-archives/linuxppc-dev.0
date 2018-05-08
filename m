Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsk5VQ8zF157
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:42 +1000 (AEST)
In-Reply-To: <20180502112948.1747-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, rostedt@goodmis.org,
 mingo@redhat.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: tracing: Remove PPC32 wart from config TRACING_SUPPORT
Message-Id: <40gMsj6lvLz9s0W@ozlabs.org>
Date: Wed,  9 May 2018 00:52:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 11:29:48 UTC, Michael Ellerman wrote:
> config TRACING_SUPPORT has an exception for PPC32, because PPC32
> didn't have irqflags tracing support.
> 
> But that hasn't been true since commit 5d38902c4838 ("powerpc: Add
> irqtrace support for 32-bit powerpc") (Jun 2009).
> 
> So remove the exception for PPC32 and the comment.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/0ea5ee035133aeb549883ddc604a65

cheers
