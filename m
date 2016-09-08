Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFr758WlzDsTF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:47:51 +1000 (AEST)
In-Reply-To: <20160826144513.A71561A245B@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Antoine Blangy <antoine.blangy@c-s.fr>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: powerpc/32: fix again csum_partial_copy_generic()
Message-Id: <3sVFr73rMsz9s3v@ozlabs.org>
Date: Thu,  8 Sep 2016 19:47:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-26-08 at 14:45:13 UTC, Christophe Leroy wrote:
> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()") introduced a bug when destination
> address is odd and len is lower than cacheline size.
> 
> In that case the resulting csum value doesn't have to be rotated one
> byte because the cache-aligned copy part is skipped so no alignment
> is performed.
> 
> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic() based on copy_tofrom_user()")
> Cc: stable@vger.kernel.org
> Reported-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8540571e01f973d321b0821f4f

cheers
