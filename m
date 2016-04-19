Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1Bn34SLzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:16:33 +1000 (AEST)
In-Reply-To: <1460552003-15409-5-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: pmladek@suse.com, jeyu@redhat.com, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [4/5] powerpc/livepatch: Add livepatch stack to struct thread_info
Message-Id: <3qq1Bm5pBgz9t8m@ozlabs.org>
Date: Tue, 19 Apr 2016 20:16:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-04 at 12:53:22 UTC, Michael Ellerman wrote:
> In order to support live patching we need to maintain an alternate
> stack of TOC & LR values. We use the base of the stack for this, and
> store the "live patch stack pointer" in struct thread_info.
> 
> Unlike the other fields of thread_info, we can not statically initialise
> that value, so it must be done at run time.
> 
> This patch just adds the code to support that, it is not enabled until
> the next patch which actually adds live patch support.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/5d31a96e6c0187f2c5d7004e00

cheers
