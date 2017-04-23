Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9nt607gxzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:18 +1000 (AEST)
In-Reply-To: <233563a070655a1015210fdb22322b0316615742.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,1/6] powerpc: ftrace: minor cleanup
Message-Id: <3w9nt56Z1Nz9s2Q@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:23 UTC, "Naveen N. Rao" wrote:
> Move the stack setup and teardown code to the ftrace_graph_caller().
> This way, we don't incur the cost of setting it up unless function graph
> is enabled for this function.
> 
> Also, remove the extraneous LR restore code after the function graph
> stub. LR has previously been restored and neither livepatch_handler()
> nor ftrace_graph_caller() return back here.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/700e64377c2c8e2406e9c4c1632e2e

cheers
