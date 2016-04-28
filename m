Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwfF00mjnzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:23:00 +1000 (AEST)
In-Reply-To: <20160426002844.GA9198@x1.distroguy.com>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Add support for userspace P9 copy paste
Message-Id: <3qwfDz4HKbz9t7W@ozlabs.org>
Date: Fri, 29 Apr 2016 00:22:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-04 at 00:28:50 UTC, Chris Smart wrote:
> The copy paste facility introduced in POWER9 provides an optimised
> mechanism for a userspace application to copy a cacheline. This is
> provided by a pair of instructions, copy and paste, while a third,
> cp_abort (copy paste abort), provides a clean up of the state in case of
> a failure.
...
> Signed-off-by: Chris Smart <chris@distroguy.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a649045e75a4b9091ea9d041f

cheers
