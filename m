Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTg22djVzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:38 +1000 (AEST)
In-Reply-To: <20170515181005.29517-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: powerpc/kprobes: Fix handling of instruction emulation on probe
 re-entry
Message-Id: <3wSTg21D76z9s82@ozlabs.org>
Date: Wed, 17 May 2017 19:34:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-15 at 18:10:05 UTC, "Naveen N. Rao" wrote:
> Commit 22d8b3dec214c ("powerpc/kprobes: Emulate instructions on kprobe
> handler re-entry") enabled emulating instructions on kprobe re-entry,
> rather than single-stepping always. However, we didn't update the single
> stepping code to only be run if the emulation fails. Also, we missed
> re-enabling preemption if the instruction emulation was successful. Fix
> those issues.
> 
> Fixes: 22d8b3dec214c ("powerpc/kprobes: Emulate instructions on kprobe
> handler re-entry")
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d04c02f8aa96d82e4cbe783f85a820

cheers
