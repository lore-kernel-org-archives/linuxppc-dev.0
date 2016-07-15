Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv21HGNzDqyl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:18 +1000 (AEST)
In-Reply-To: <1467695057-12431-9-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [08/41] powerpc: Move epapr_paravirt_early_init() to
 early_init_devtree()
Message-Id: <3rrTv13X12z9sDG@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:44 UTC, Benjamin Herrenschmidt wrote:
> The function is called by both 32-bit and 64-bit early setup right
> after early_init_devtree(). All it does is run yet another early
> DT parser which is precisely what early_init_devtree() is about,
> so move it in there.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/da6a97bf12d57e341029b3624e

cheers
