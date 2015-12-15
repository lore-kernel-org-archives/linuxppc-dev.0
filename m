Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E2981A033F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:16 +1100 (AEDT)
In-Reply-To: <1449612560-2587-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: selftests/powerpc: Add test to check if VSRs are corrupted
Message-Id: <20151215112714.F2C6F14076E@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-12 at 22:09:20 UTC, Rashmica Gupta wrote:
> When a transaction is aborted, VSR values should rollback to the
> checkpointed values before the transaction began. VSRs used elsewhere in
> the kernel during a transaction, or while the transaction is suspended
> should not affect the checkpointed values.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5f337e3e5b04b32793fd51ad

cheers
