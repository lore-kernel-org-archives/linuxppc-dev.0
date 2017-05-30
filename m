Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSX464v4zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:16 +1000 (AEST)
In-Reply-To: <20170501120110.21888-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/64s: Fix FIXUP_ENDIAN non-maskable interrupt
 reentrancy
Message-Id: <3wcSX45V80z9s72@ozlabs.org>
Date: Tue, 30 May 2017 19:11:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-01 at 12:01:09 UTC, Nicholas Piggin wrote:
> FIXUP_ENDIAN uses SRR[01] with MSR_RI=1, which gets corrupted if there
> is an interleaving system reset or machine check interrupt.
> 
> Set MSR_RI=0 before setting SRRs. The rfid will restore MSR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f1fe5252018075e18d7f0c0e23ee17

cheers
