Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBb6qKkzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:07 +1100 (AEDT)
In-Reply-To: <9dd0626d840e60b15603d767ce1576630fe1376d.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [v2,1/2] powerpc: remove extraneous header from asm-prototypes.h
Message-Id: <3tPxBb4zk5z9t2C@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-21 at 17:06:40 UTC, "Naveen N. Rao" wrote:
> Commit 03465f899bda ("powerpc: Use kprobe blacklist for exception
> handlers") removed __kprobes annotation from some of the prototypes,
> but left the kprobes header include directive unchanged. Remove it as it
> is no longer needed.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/82de5797a26087c651a06de327e6aa

cheers
