Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLV0tLtzDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:30 +1000 (AEST)
In-Reply-To: <5aa5ca47d531a530285fe5b453f6921d0960bde3.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,2/6] powerpc: ftrace: restore LR from pt_regs
Message-Id: <3wBhLT756kz9s8S@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:24 UTC, "Naveen N. Rao" wrote:
> Pass the real LR to the ftrace handler. This is needed for
> KPROBES_ON_FTRACE for the pre handlers.
> 
> Also, with KPROBES_ON_FTRACE, the link register may be updated by the
> pre handlers or by a registed kretprobe. Honor updated LR by restoring
> it from pt_regs, rather than from the stack save area.
> 
> Live patch and function graph continue to work fine with this change.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2f59be5b970b503ca8db1cb723b155

cheers
