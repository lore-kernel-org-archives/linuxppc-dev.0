Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLX3GQKzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:32 +1000 (AEST)
In-Reply-To: <7c3fcc090894c7d180274a17a7dfa09ca14df51f.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,
 5/6] powerpc: introduce a new helper to obtain function entry points
Message-Id: <3wBhLX1nRNz9s8V@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:27 UTC, "Naveen N. Rao" wrote:
> kprobe_lookup_name() is specific to the kprobe subsystem and may not
> always return the function entry point (in a subsequent patch for
> KPROBES_ON_FTRACE). For looking up function entry points, introduce a
> separate helper and use the same in optprobes.c
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b32cd1715378c9a3856df4a80920f

cheers
