Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6f5R5LzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:46 +1100 (AEDT)
In-Reply-To: <20161127134620.74007843@roar.ozlabs.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
Subject: Re: [2/3] powerpc: allow compilation on cross-endian toolchain
Message-Id: <3vdQ6f4vgvz9sN5@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-11-27 at 02:46:20 UTC, Nicholas Piggin wrote:
> Subject: [PATCH] powerpc: allow compilation on cross-endian toolchain
> 
> GCC can compile with either endian, but the ABI version always
> defaults to the default endian. Alan Modra says:
> 
>   you need both -mbig and -mabi=elfv1 to make a powerpc64le gcc
>   generate powerpc64 code
> 
> The opposite is true for powerpc64 when generating -mlittle it
> requires -mabi=elfv2 to generate v2 ABI. This change adds ABI
> annotations together with endianness. The kernel with ELFv2 ABI
> also uses -mcall-aixdesc, but boot/ does not.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4dc831aa88132f835cefe876aa0206

cheers
