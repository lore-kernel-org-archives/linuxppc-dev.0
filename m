Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkp6STZzDqsw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:10 +1000 (AEST)
In-Reply-To: <20160616233442.GA14583@distroguy.com>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,2/2] selftests/powerpc: Test unaligned copy and paste
Message-Id: <3rkQkp5bbRz9t17@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-16-06 at 23:34:47 UTC, Chris Smart wrote:
> Test that an ISA 3.0 compliant machine performing an unaligned copy,
> copy_first, paste or paste_last is sent a SIGBUS.
> 
> Signed-off-by: Chris Smart <chris@distroguy.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4375088072295b09cc5d9bf7a8

cheers
