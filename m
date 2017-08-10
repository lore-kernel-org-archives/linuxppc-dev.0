Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSn1r1gvdzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 22:07:12 +1000 (AEST)
In-Reply-To: <20170809124126.28907-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/6] powerpc: NMI IPI improve lock primitive
Message-Id: <3xSn1q4Srmz9t31@ozlabs.org>
Date: Thu, 10 Aug 2017 22:07:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-09 at 12:41:21 UTC, Nicholas Piggin wrote:
> When the NMI IPI lock is contended, spin at low SMT priority, using
> loads only, and with interrupts enabled (where possible). This
> improves behaviour under high contention (e.g., a system crash when
> a number of CPUs are trying to enter the debugger).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0459ddfdb31e7d812b555a2530ecba

cheers
