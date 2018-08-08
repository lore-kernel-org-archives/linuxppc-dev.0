Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltvl5bdWzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:23 +1000 (AEST)
In-Reply-To: <20180411051801.30194-2-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [2/3] powerpc/xive: Remove now useless pr_debug statements
Message-Id: <41ltvk2nJsz9s4V@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-11 at 05:18:00 UTC, Benjamin Herrenschmidt wrote:
> Those overly verbose statement in the setup of the pool VP
> aren't particularly useful (esp. considering we don't actually
> use the pool, we configure it bcs HW requires it only). So
> remove them which improves the code readability.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dbc5740247961d6b060737620520dc

cheers
