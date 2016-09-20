Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhv4pkFzDsfp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:27 +1000 (AEST)
In-Reply-To: <20160914032147.11728-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Alan Modra <amodra@gmail.com>
Subject: Re: powerpc/64: syscall ABI
Message-Id: <3sdjhv2qRPz9t0w@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-14-09 at 03:21:47 UTC, Nicholas Piggin wrote:
> Add some documentation for the 64-bit syscall ABI, which doesn't seem
> to be documented elsewhere.
> 
> This attempts to documented existing practice. The only small
> discrepancy is glibc clobbers not quite matching the kernel (e.g.,
> xer, some vsyscalls trash cr1 whereas glibc only clobbers cr0). These
> will be resolved after this document is merged.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7b8845a2a2ec4d9658225cf9c5

cheers
