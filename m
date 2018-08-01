Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDQ0fj7zF1Cq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:24:06 +1000 (AEST)
In-Reply-To: <6ee3e95be4abc5ed842d3b4bd5d0fedc8fc208ea.1530807556.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,06/16] powerpc: clean inclusions of asm/feature-fixups.h
Message-Id: <41gMDN5xFlz9sBD@ozlabs.org>
Date: Wed,  1 Aug 2018 15:24:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-05 at 16:25:01 UTC, Christophe Leroy wrote:
> files not using feature fixup don't need asm/feature-fixups.h
> files using feature fixup need asm/feature-fixups.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2c86cd188f8a5631f3d75a1dea14d2

cheers
