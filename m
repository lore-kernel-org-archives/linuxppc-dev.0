Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2M3FwSzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:31 +1000 (AEST)
In-Reply-To: <20170724042803.25848-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [1/6] powerpc/mm: Move pgdir setting into a helper
Message-Id: <3xdP2M2BRwz9sR9@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-24 at 04:27:58 UTC, Benjamin Herrenschmidt wrote:
> Makes switch_mm_irqs_off() a bit more readable
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Patches 1-2, 4-6 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43ed84a891b70165a621a5c9219694

cheers
