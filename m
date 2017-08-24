Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2P1sTqzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:33 +1000 (AEST)
In-Reply-To: <20170811163912.28783-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,01/14] powerpc/64s: masked interrupt avoid branch
Message-Id: <3xdP2P0vx4z9sRW@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-11 at 16:38:59 UTC, Nicholas Piggin wrote:
> Interrupts which do not require EE to be cleared can all
> be tested with a single bitwise test.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patches 1-9 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e0c827c09c0d04d77616a4506a71b3

cheers
