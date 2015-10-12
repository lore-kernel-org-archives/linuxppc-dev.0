Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BBD31A03A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:17:19 +1100 (AEDT)
In-Reply-To: <4fd8daff1bb5daad99d909aa75ff5c2702c4c490.1437117145.git.christophe.jaillet@wanadoo.fr>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] powerpc/nvram: Add missing kfree in error path
Message-Id: <20151012111719.07ACD14029E@ozlabs.org>
Date: Mon, 12 Oct 2015 22:17:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-17-07 at 07:19:59 UTC, Christophe Jaillet wrote:
> If 'nvram_write_header' fails, then 'new_part' should be freed, otherwise,
> there is a memory leak.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7d523187173294f6ae3b86a4

cheers
