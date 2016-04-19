Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1Br16PnzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:16:36 +1000 (AEST)
In-Reply-To: <1460552003-15409-6-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: pmladek@suse.com, jeyu@redhat.com, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [5/5] powerpc/livepatch: Add live patching support on ppc64le
Message-Id: <3qq1Bp6dFtz9t8n@ozlabs.org>
Date: Tue, 19 Apr 2016 20:16:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-04 at 12:53:23 UTC, Michael Ellerman wrote:
> Add the kconfig logic & assembly support for handling live patched
> functions. This depends on DYNAMIC_FTRACE_WITH_REGS, which in turn
> depends on the new -mprofile-kernel ftrace ABI, which is only supported
> currently on ppc64le.
...
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/85baa095497f3e590df9f6c893

cheers
