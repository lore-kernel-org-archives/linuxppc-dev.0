Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9nt46vKTzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:16 +1000 (AEST)
In-Reply-To: <bdf0464c4b7f0d4aa0099d3e60ebeb63ba4b07d1.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,7/7] powerpc: kprobes: remove duplicate saving of msr
Message-Id: <3w9nt456bbz9s2P@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:51:06 UTC, "Naveen N. Rao" wrote:
> set_current_kprobe() already saves regs->msr into kprobe_saved_msr. Remove
> the redundant save.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d08f8a28bcc8c2004a7186839148fc

cheers
