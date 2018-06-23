Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Cb5v608LzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 22:56:03 +1000 (AEST)
In-Reply-To: <20180612093808.30679-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stable@kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Subject: Re: powerpc/64s/radix: Fix radix_kvm_prefetch_workaround paca access
 of not possible CPU
Message-Id: <41Cb5v4YYVz9s2t@ozlabs.org>
Date: Sat, 23 Jun 2018 22:56:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-12 at 09:38:08 UTC, Nicholas Piggin wrote:
> If possible CPUs are limited (e.g., by kexec), then the kvm prefetch
> workaround function can access the paca pointer for a !possible CPU.
> 
> Fixes: d2e60075a3d44 ("powerpc/64: Use array of paca pointers and allocate pacas individually")
> Cc: stable@kernel.org
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Tested-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/758380b8155f69b4e2f77f27562f8a

cheers
