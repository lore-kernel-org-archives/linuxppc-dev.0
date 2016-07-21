Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9z16TyqzDqYp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:33 +1000 (AEST)
In-Reply-To: <1467695057-12431-7-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [06/41] powerpc: Move 64-bit feature fixup earlier
Message-Id: <3rw9z15VZNz9snm@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:42 UTC, Benjamin Herrenschmidt wrote:
> Make it part of early_setup() as we really want the feature fixups
> to be applied before we turn on the MMU since they can have an impact
> on the various assembly path related to MMU management and interrupts.
> 
> This makes 64-bit match what 32-bit does.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c4bd6cb87c9e28a7d9f4a97db5

cheers
