Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkl24r2zDqps
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:07 +1000 (AEST)
In-Reply-To: <20160616233340.GA14449@distroguy.com>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-Id: <3rkQkl1GbWz9sdn@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-16-06 at 23:33:45 UTC, Chris Smart wrote:
> Calling ISA 3.0 instructions copy, copy_first, paste and paste_last
> generates an alignment fault when copying or pasting unaligned
> data (128 byte). We catch this and send SIGBUS to the userspace
> process that caused it.
> 
> We do not emulate these because paste may contain additional metadata
> when pasting to a co-processor and paste_last is the synchronisation
> point for preceding copy/paste sequences.
> 
> Thanks to Michael Neuling <mikey@neuling.org> for his help.
> 
> Signed-off-by: Chris Smart <chris@distroguy.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ae26b36f8098c793a754549662

cheers
