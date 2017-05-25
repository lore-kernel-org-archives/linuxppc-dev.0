Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVLH2GmczDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:22:31 +1000 (AEST)
In-Reply-To: <20170520042949.29359-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: benh@ozlabs.au.ibm.com, tuliom@linux.vnet.ibm.com,
 Steve Munroe <sjmunroe@us.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Bill Schmidt <wschmidt@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: powerpc: add PPC_FEATURE userspace bits for SCV and DARN
 instructions
Message-Id: <3wYVLH13PDz9s8Y@ozlabs.org>
Date: Thu, 25 May 2017 23:22:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-05-20 at 04:29:49 UTC, Nicholas Piggin wrote:
> Providing "scv" support to userspace requires kernel support, so it
> must be advertised as independently to the base ISA 3 instruction set.
> 
> The darn instruction relies on firmware enablement, so it has been
> decided to split this out from the core ISA 3 feature as well.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a4700a26107241cc7b9ac8528b2c67

cheers
