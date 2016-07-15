Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv55KcHzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:21 +1000 (AEST)
In-Reply-To: <1467695057-12431-10-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [09/41] powerpc: Update obsolete comments in setup_32.c about
 entry conditions
Message-Id: <3rrTv41LZYz9s9Y@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:45 UTC, Benjamin Herrenschmidt wrote:
> early_init() is called in-place before kernel relocation and using
> whatever MMU setup exists at the point the kernel is entered.
> 
> machine_init() is called after relocation and after some initial
> mapping of PAGE_OFFSET has been established (typically using BATs
> on 6xx/7xx/7xxx processors or some form of bolted TLB on others).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd7c93cca36911baf2eb2bc386

cheers
