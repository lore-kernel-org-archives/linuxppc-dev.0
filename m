Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9nt3618WzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:15 +1000 (AEST)
In-Reply-To: <20170412111851.4708-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [v2] powerpc: kprobes: convert __kprobes to NOKPROBE_SYMBOL()
Message-Id: <3w9nt34m66z9s2G@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 11:18:51 UTC, "Naveen N. Rao" wrote:
> Along similar lines as commit 9326638cbee2 ("kprobes, x86: Use
> NOKPROBE_SYMBOL() instead of __kprobes annotation"), convert __kprobes
> annotation to either NOKPROBE_SYMBOL() or nokprobe_inline. The latter
> forces inlining, in which case the caller needs to be added to
> NOKPROBE_SYMBOL().
...
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/71f6e58e5efe09b98a1862d4c25976

cheers
