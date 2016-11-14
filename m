Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzP27JGzDvjc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:05 +1100 (AEDT)
In-Reply-To: <1478148061-5724-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: [1/2] selftests/powerpc: Abort load_unaligned_zeropad on
 unhandled SEGV
Message-Id: <3tHTzP0Ptdz9t17@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-11 at 04:41:00 UTC, Michael Ellerman wrote:
> If the load unaligned zeropad test takes a SEGV which can't be handled,
> we increment segv_error, print the offending NIP and then return without
> taking any further action. In almost all cases this means we'll just
> take the SEGV again, and loop eternally spamming the console.
> 
> Instead just abort(), it's a fatal error in the test. The test harness
> will notice that the child died and print a nice message for us.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/06236f4efb926aa433e2cb3e36e846

cheers
