Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLZ2dv0zDqFc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:34 +1000 (AEST)
In-Reply-To: <63c796a86e56ae64e88ba1fc55ca864789c9b22e.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,
 3/6] kprobes: Skip preparing optprobe if the probe is ftrace-based
Message-Id: <3wBhLZ0lKsz9s8S@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:25 UTC, "Naveen N. Rao" wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Skip preparing optprobe if the probe is ftrace-based, since anyway, it
> must not be optimized (or already optimized by ftrace).
> 
> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a460246c70d1ac25a0717112e7a167

cheers
