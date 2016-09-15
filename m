Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZswZ3nLBzDsYT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:07:42 +1000 (AEST)
In-Reply-To: <1473928774-22519-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv/pci: Fix missed TCE invalidations that should
 fallback to OPAL
Message-Id: <3sZswZ2tWfz9sdm@ozlabs.org>
Date: Fri, 16 Sep 2016 08:07:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 08:39:34 UTC, Michael Ellerman wrote:
> In commit f0228c413011 ("powerpc/powernv/pci: Fallback to OPAL for TCE
> invalidations"), we added logic to fallback to OPAL for doing TCE
> invalidations if we can't do it in Linux.
> 
> Ben sent a v2 of the patch, containing these additional call sites, but
> I had already applied v1 and didn't notice. So fix them now.
> 
> Fixes: f0228c413011 ("powerpc/powernv/pci: Fallback to OPAL for TCE invalidations")
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/ed7d9a1d7da6fe7b1c7477dc70

cheers
