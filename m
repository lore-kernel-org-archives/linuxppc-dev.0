Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqqj21LRzDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:22:41 +1000 (AEST)
In-Reply-To: <7a91bf93179afb3ada72948e8feb5e5f09fb64c4.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v2, 2/4] powerpc/ftrace: Pass the correct stack pointer for
 DYNAMIC_FTRACE_WITH_REGS
Message-Id: <3wrqqj05Wwz9s8F@ozlabs.org>
Date: Mon, 19 Jun 2017 22:22:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 10:48:16 UTC, "Naveen N. Rao" wrote:
> For DYNAMIC_FTRACE_WITH_REGS, we should be passing-in the original set
> of registers in pt_regs, to capture the state _before_ ftrace_caller.
> However, we are instead passing the stack pointer *after* allocating a
> stack frame in ftrace_caller. Fix this by saving the proper value of r1
> in pt_regs. Also, use SAVE_10GPRS() to simplify the code.
> 
> Fixes: 153086644fd1f ("powerpc/ftrace: Add support for -mprofile-kernel
> ftrace ABI")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a4979a7e71eb8da976cbe4a0a1fa50

cheers
