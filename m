Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDY3QPKzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:24:13 +1000 (AEST)
In-Reply-To: <050c24f2b82d2dcf0007398ec69b7f0b073c3188.1530807556.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,16/16] powerpc: split asm/tlbflush.h
Message-Id: <41gMDX6qTQz9s3q@ozlabs.org>
Date: Wed,  1 Aug 2018 15:24:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-05 at 16:25:21 UTC, Christophe Leroy wrote:
> Split asm/tlbflush.h into:
> asm/nohash/tlbflush.h
> asm/book3s/32/tlbflush.h
> asm/book3s/64/tlbflush.h (already existing)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/405cb4024e52b137685213b377ea3f

cheers
