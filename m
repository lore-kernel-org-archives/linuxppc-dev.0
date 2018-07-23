Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h61j2lzDsGJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:18 +1000 (AEST)
In-Reply-To: <20180711071017.5128-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, chris@distroguy.com
Subject: Re: [1/3] selftests/powerpc: Remove Power9 copy_unaligned test
Message-Id: <41Z4h508fJz9s7Q@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-11 at 07:10:15 UTC, Michael Ellerman wrote:
> This is a test of the ISA 3.0 "copy" instruction. That instruction has
> an L field, which if set to 1 specifies that "the instruction
> identifies the beginning of a move group" (pp 858). That's also
> referred to as "copy first" vs "copy".
> 
> In ISA 3.0B the copy instruction does not have an L field, and the
> corresponding bit in the instruction must be set to 1.
> 
> This test is generating a "copy" instruction, not a "copy first", and
> so on Power9 (which implements 3.0B), this results in an illegal
> instruction.
> 
> So just drop the test entirely. We still have copy_first_unaligned to
> test the "copy first" behaviour.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Neuling <mikey@neuling.org>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/83039f22ba2f6aff935a2acbb6bf67

cheers
