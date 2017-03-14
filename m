Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCc46L78zDqqP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:45:56 +1100 (AEDT)
In-Reply-To: <20170228020048.8862-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/64s: fix handling of non-synchronous machine checks
Message-Id: <3vjCc45Fp9z9s3l@ozlabs.org>
Date: Tue, 14 Mar 2017 22:45:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-28 at 02:00:46 UTC, Nicholas Piggin wrote:
> A synchronous machine check is an exception raised by the attempt to
> execute the current instruction. If the error can't be corrected, it
> can make sense to SIGBUS the currently running process.
> 
> In other cases, the error condition is not related to the current
> instruction, so killing the current process is not the right thing to
> do.
> 
> Today, all machine checks are MCE_SEV_ERROR_SYNC, so this has no
> practical change. It will be used to handle POWER9 asynchronous
> machine checks.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1363875bdb6317a2d0798284d7aaf3

cheers
