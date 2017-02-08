Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ2FY2001zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 11:31:29 +1100 (AEDT)
In-Reply-To: <20170127042433.14259-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts
Message-Id: <3vJ2FY1Ghhz9s65@ozlabs.org>
Date: Wed,  8 Feb 2017 11:31:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-27 at 04:24:33 UTC, Nicholas Piggin wrote:
> The branch from hmi_exception_early to hmi_exception_realmode must use
> a "relocatable-style" branch, because it is branching from unrelocated
> exception code to beyond __end_interrupts.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/2337d207288f163e10bd8d4d7eeb0c

cheers
