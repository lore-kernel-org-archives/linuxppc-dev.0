Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fX24h4zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:16 +1000 (AEST)
In-Reply-To: <1458125780-22841-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/mm: Remove long disabled SLB code
Message-Id: <3qk8fW6FNqz9t42@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-16-03 at 10:56:20 UTC, Michael Ellerman wrote:
> We have a bunch of SLB related code in the tree which is there to handle
> dynamic VSIDs - but currently it's all disabled at compile time. The
> comments say "Keep that around for when we re-implement dynamic VSIDs".
> 
> But that was over 10 years ago (commit 3c726f8dee6f ("[PATCH] ppc64:
> support 64k pages")). The chance that it would still work unchanged is
> minimal, and in the meantime it's confusing to folks browsing/grepping
> the code. If we ever want to re-instate it, it's in the git history.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1f4c66e80574e85aff25179fc7

cheers
