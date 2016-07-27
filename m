Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzyBq0l6lzDrdS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:32:51 +1000 (AEST)
In-Reply-To: <1467200511-19033-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: cyrilbur@gmail.com
Subject: Re: [v2] selftests/powerpc: exec() with suspended transaction
Message-Id: <3rzyBp569Bz9t2P@ozlabs.org>
Date: Thu, 28 Jul 2016 00:32:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 11:41:51 UTC, Michael Ellerman wrote:
> From: Cyril Bur <cyrilbur@gmail.com>
> 
> Perform an exec() class syscall with a suspended transaction.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> [mpe: Fix build errors, use a single binary for the test]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/a431b946db581d6a121d035a88

cheers
