Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg365hBnzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:46 +1000 (AEST)
In-Reply-To: <20180205051716.22529-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/tm: Update function prototype comment
Message-Id: <41Zg363x3jz9s21@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-02-05 at 05:17:16 UTC, Cyril Bur wrote:
> In commit eb5c3f1c8647 ("powerpc: Always save/restore checkpointed regs
> during treclaim/trecheckpoint") __tm_recheckpoint was modified to no
> longer take the second parameter 'unsigned long orig_msr' as part of a
> TM rewrite to simplify the reclaiming/recheckpointing process.
> 
> There is a comment in the asm file where the function is delcared which
> has an incorrect prototype with the 'orig_msr' parameter.
> 
> This patch corrects the comment.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a596a7e91710d26fd862e3b7031c40

cheers
