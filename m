Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67FD61A0B63
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 19:34:52 +1100 (AEDT)
In-Reply-To: <1445925762.1856.17.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: powerpc/dma: dma_set_coherent_mask() should not be GPL only
Message-Id: <20151028083452.527CD140D92@ozlabs.org>
Date: Wed, 28 Oct 2015 19:34:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-27-10 at 06:02:42 UTC, Benjamin Herrenschmidt wrote:
> When turning this from inline to an exported function I was a bit
> over-eager and made it GPL only. This prevents the use of pretty much
> all non-GPL PCI driver which is a bit over the top. Let's bring it
> back in line with other architecture.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/977bf062bba3eb8d03f66d5b

cheers
