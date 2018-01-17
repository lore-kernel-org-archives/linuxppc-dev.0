Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Ls5rhKzF0VR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:32:53 +1100 (AEDT)
In-Reply-To: <20171208163430.1B20C6B864@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/32: book3s - fix compile error with CONFIG_PPC_PTDUMP
Message-Id: <3zM7Lr1PVlz9sRW@ozlabs.org>
Date: Thu, 18 Jan 2018 00:32:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-08 at 16:34:29 UTC, Christophe Leroy wrote:
> This patch remove CONFIG_PPC_HTDUMP if not PPC_BOOK3S_64 to avoid
> below compile failure on BOOK3S_32:
> 
>   CC      arch/powerpc/mm/dump_linuxpagetables.o
>   CC      arch/powerpc/mm/dump_hashpagetable.o
> In file included from arch/powerpc/mm/dump_hashpagetable.c:27:0:
> ./arch/powerpc/include/asm/plpar_wrappers.h: In function 'get_cede_latency_hint':
...
> 
> Fixes: dd5ac03e09554 ("powerpc/mm: Fix page table dump build
> on non-Book3S")
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94d3084a0f8cbca9ceea2835ac842c

cheers
