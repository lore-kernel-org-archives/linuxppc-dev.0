Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pk1RhYzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:50 +1000 (AEST)
In-Reply-To: <a0105d18c39c419ed3b30270d0c2f30d10aa1947.1492772606.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/4] powerpc: Discard ffs()/__ffs() function and use builtin
 functions instead
Message-Id: <3wh9pj6YD0z9sD5@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-04-21 at 11:18:46 UTC, Christophe Leroy wrote:
> With the ffs() function as defined in arch/powerpc/include/asm/bitops.h
> GCC will not optimise the code in case of constant parameter, as shown
> by the small exemple below.
...
> 
> In addition, when reading the generated vmlinux, we can observe
> that with the builtin functions, GCC sometimes efficiently spreads
> the instructions within the generated functions while the inline
> assembly force them to remain grouped together.
> 
> __builtin_ffs() is already used in arch/powerpc/include/asm/page_32.h
> 
> Those builtins have been in GCC since at least 3.4.6 (see
> https://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/Other-Builtins.html )
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f83647d642270f6b9d75736817fb5a

cheers
