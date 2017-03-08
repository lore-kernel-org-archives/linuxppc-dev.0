Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6w2KZ3zDqYZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:26:00 +1100 (AEDT)
In-Reply-To: <1488798929-4546-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: pc@us.ibm.com
Subject: Re: powerpc/64: Fix L1D cache shape vector reporting L1I values
Message-Id: <3vdQ6w15bkz9sNH@ozlabs.org>
Date: Wed,  8 Mar 2017 18:26:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 11:15:29 UTC, Michael Ellerman wrote:
> It seems we didn't pay quite enough attention when testing the new cache
> shape vectors, which means we didn't notice the bug where the vector for
> the L1D was using the L1I values. Fix it, resulting in eg:
> 
>   L1I  cache size:     0x8000      32768B         32K
>   L1I  line size:        0x80       8-way associative
>   L1D  cache size:    0x10000      65536B         64K
>   L1D  line size:        0x80       8-way associative
> 
> Fixes: 98a5f361b862 ("powerpc: Add new cache geometry aux vectors")
> Cut-and-paste-bug-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Badly-reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/9c7a00868c3a77c86ab07a2c51f3bb

cheers
