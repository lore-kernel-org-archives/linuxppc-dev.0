Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5gB09c7zDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:39:18 +1000 (AEST)
In-Reply-To: <1465232170-16822-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v4] powerpc: Define and use PPC64_ELF_ABI_v2/v1
Message-Id: <3rV5g81hqHz9t1q@ozlabs.org>
Date: Wed, 15 Jun 2016 22:39:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 16:56:10 UTC, "Naveen N. Rao" wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> We're approaching 20 locations where we need to check for ELF ABI v2.
> That's fine, except the logic is a bit awkward, because we have to check
> that _CALL_ELF is defined and then what its value is.
> 
> So check it once in asm/types.h and define PPC64_ELF_ABI_v2 when ELF ABI
> v2 is detected.
> 
> We also have a few places where what we're really trying to check is
> that we are using the 64-bit v1 ABI, ie. function descriptors. So also
> add a #define for that, which simplifies several checks.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f55d966536034d33476fdd43c4

cheers
