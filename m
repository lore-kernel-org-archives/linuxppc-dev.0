Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ6zc3cYlzDr4L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:24:28 +1100 (AEDT)
In-Reply-To: <20160315130750.0E43C1A2375@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
Message-Id: <3qQ6zc2Nqrz9sRB@ozlabs.org>
Date: Wed, 16 Mar 2016 21:24:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-15-03 at 13:07:49 UTC, Christophe Leroy wrote:
> Some versions of GCC, reportedly before 4.8, fail with
> arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
> addressable
> 
> Change the one-element array into a simple variable to avoid this.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2e098dcee6208a690f73e11feb

cheers
