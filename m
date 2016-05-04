Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0J0fh4zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:32 +1000 (AEST)
In-Reply-To: <20160502035133.GA28672@distroguy.com>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: selftests/powerpc: Test cp_abort during context switch
Message-Id: <3r0Y0H63hpz9t5c@ozlabs.org>
Date: Thu,  5 May 2016 08:40:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-05 at 03:51:38 UTC, Chris Smart wrote:
> Test that performing a copy paste sequence in userspace on P9 does not
> result in a leak of the copy into the paste of another process.
> 
> This is based on Anton Blanchard's context_switch benchmarking code. It
> sets up two processes tied to the same CPU, one which copies and one
> which pastes.
> 
> The paste should never succeed and the test fails if it does.
> 
> This is a test for commit, "8a64904 powerpc: Add support for userspace
> P9 copy paste."
> 
> Patch created with much assistance from Michael Neuling
> <mikey@neuling.org>
> 
> Signed-off-by: Chris Smart <chris@distroguy.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3a3c5de218a676440e535035d9

cheers
