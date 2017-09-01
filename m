Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKqC3Y0zzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:59 +1000 (AEST)
In-Reply-To: <1504066360-30128-2-git-send-email-paulus@ozlabs.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,
 01/17] powerpc: Correct instruction code for xxlor instruction
Message-Id: <3xkKqB58Ddz9t3p@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 04:12:24 UTC, Paul Mackerras wrote:
> The instruction code for xxlor that commit 0016a4cf5582 ("powerpc:
> Emulate most Book I instructions in emulate_step()", 2010-06-15)
> added is actually the code for xxlnor.  It is used in get_vsr()
> and put_vsr() and the effect of the error is that if emulate_step
> is used to emulate a VSX load or store from any register other
> than vsr0, the bitwise complement of the correct value will be
> loaded or stored.  This corrects the error.
> 
> Fixes: 0016a4cf5582 ("powerpc: Emulate most Book I instructions in emulate_step()")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/93b2d3cf3733b4060d3623161551f5

cheers
