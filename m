Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTKRh6FcJzDvh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 23:27:12 +1100 (AEDT)
In-Reply-To: <20161116182756.GE2697@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, stable <stable@vger.kernel.org>
Subject: Re: powerpc/boot: Fix build failure in 32-bit boot wrapper
Message-Id: <3tTKRh4RW6z9t2G@ozlabs.org>
Date: Wed, 30 Nov 2016 23:27:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 18:27:56 UTC, Ben Hutchings wrote:
> OPAL is not callable from 32-bit mode and the assembly code for it
> may not even build (depending on how binutils was configured).
> 
> References: https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpcspe&ver=4.8.7-1&stamp=1479203712
> Fixes: 656ad58ef19e ("powerpc/boot: Add OPAL console to epapr wrappers")
> Cc: stable <stable@vger.kernel.org> # 4.8
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/10c77dba40ff58fc03587b3b60725b

cheers
