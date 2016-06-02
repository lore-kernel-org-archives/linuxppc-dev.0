Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKzPZ3qzpzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 17:29:22 +1000 (AEST)
In-Reply-To: <20160523084549.A7B841A239A@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc32: get rid of sub_reloc_offset()
Message-Id: <3rKzPZ2ZMgz9t5Q@ozlabs.org>
Date: Thu,  2 Jun 2016 17:29:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-23-05 at 08:45:49 UTC, Christophe Leroy wrote:
> sub_reloc_offset() has not been used since
> commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc")
> which removed include/asm-ppc/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/misc_32.S | 14 --------------
>  1 file changed, 14 deletions(-)

Thanks.

For future patches can you use "powerpc/32:" as your prefix, thanks.

cheers
