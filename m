Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W9k1xFYzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:46:34 +1000 (AEST)
In-Reply-To: <20160802080705.69A9F1A2394@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: antoine.blangy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2] powerpc/32: fix csum_partial_copy_generic()
Message-Id: <3s8W9k03Pwz9t1m@ozlabs.org>
Date: Wed, 10 Aug 2016 22:46:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 08:07:05 UTC, Christophe Leroy wrote:
> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()") introduced a bug when destination
> address is odd and initial csum is not null
> 
> In that (rare) case the initial csum value has to be rotated one byte
> as well as the resulting value is
> 
> This patch also fixes related comments
> 
> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic() based on copy_tofrom_user()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1bc8b816cb8058c31f61fe7844

cheers
