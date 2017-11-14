Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG12xgrzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:09 +1100 (AEDT)
In-Reply-To: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [1/4] powerpc/kprobes: Disable preemption before invoking probe
 handler for optprobes
Message-Id: <3yblG11vGfz9sPs@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-23 at 16:37:38 UTC, "Naveen N. Rao" wrote:
> Per Documentation/kprobes.txt, probe handlers need to be invoked with
> preemption disabled. Update optimized_callback() to do so. Also move
> get_kprobe_ctlblk() invocation post preemption disable, since it
> accesses pre-cpu data.
> 
> This was not an issue so far since optprobes wasn't selected if
> CONFIG_PREEMPT was enabled. Commit a30b85df7d599f ("kprobes: Use
> synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y") changes
> this.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a2d71a3f2737e2448aa68de2b6052

cheers
