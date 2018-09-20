Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SS3nDmzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
In-Reply-To: <1529362784-14194-2-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [v2,2/4] powerpc/tm: Fix HTM documentation
Message-Id: <42G3SS2DqHz9sCD@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 22:59:42 UTC, Breno Leitao wrote:
> This patch simply fix part of the documentation on the HTM code.
> 
> This fixes reference to old fields that were renamed in commit
> 000ec280e3dd ("powerpc: tm: Rename transct_(*) to ck(\1)_state")
> 
> It also documents better the flow after commit eb5c3f1c8647 ("powerpc:
> Always save/restore checkpointed regs during treclaim/trecheckpoint"),
> where tm_recheckpoint can recheckpoint what is in ck{fp,vr}_state blindly.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-By: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/96695563cebfb810b09479a9951ebb

cheers
