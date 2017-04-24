Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLR2T2GzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:27 +1000 (AEST)
In-Reply-To: <7f2eee86805057a5173f19a2b893ebdccdb91048.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,1/7] kprobes: convert kprobe_lookup_name() to a function
Message-Id: <3wBhLR1bLpz9s8c@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:51:00 UTC, "Naveen N. Rao" wrote:
> The macro is now pretty long and ugly on powerpc. In the light of
> further changes needed here, convert it to a __weak variant to be
> over-ridden with a nicer looking function.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/49e0b4658fe6aab5bf6bfe0738a86c

cheers
